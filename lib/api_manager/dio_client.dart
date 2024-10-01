import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mathematics_ai/api_manager/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constant_exports.dart';


class DioClient {
  DioClient() {
    _dio.interceptors.add(
      CookieManager(cookieJar),
    );
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  final Dio _dio = Dio(BaseOptions(
    baseUrl: Endpoints.serverURL,
    connectTimeout: Endpoints.connectionTimeout,
    receiveTimeout: Endpoints.connectionTimeout,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ),
  );

  final cookieJar = CookieJar();
  final _storage = const FlutterSecureStorage();

  Future<String?> _getToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<void> _saveToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  Future<void> _refreshToken() async {
    final refreshToken = await _storage.read(key: 'refresh_token');
    if (refreshToken == null) {
      throw Exception('Refresh token not available');
    }

    try {
      final response = await _dio.post(
        'authentication/token/refresh',
        data: {'refresh': refreshToken},
      );
      final newToken = response.data['access'];
      await _saveToken(newToken);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        // Redirect to login if token refresh fails
        throw Exception('Token expired, redirect to login');
      }
    }
  }

  Future<void> _saveCookies(List<Cookie> cookies) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      'cookies',
      cookies.map((cookie) => cookie.toString()).toList(),
    );
  }

  Future<List<Cookie>> _loadCookies() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? cookieStrings = prefs.getStringList('cookies');
    if (cookieStrings != null) {
      return cookieStrings
          .map((cookieString) => Cookie.fromSetCookieValue(cookieString))
          .toList();
    } else {
      return [];
    }
  }

  Future<Response> _makeRequest(
      String method,
      String uri, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
        Options? options,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    final String? token = await _getToken();

    options ??= Options(method: method);
    options.headers ??= {};
    options.headers!['Authorization'] = 'JWT $token';

    try {
      final response = await _dio.request(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      // Save cookies after the request
      final List<Cookie> cookies =
      await cookieJar.loadForRequest(response.requestOptions.uri);
      if (cookies.isNotEmpty) {
        await _saveCookies(cookies);
      }

      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        // Token expired, try refreshing token
        await _refreshToken();
        return _makeRequest(
          method,
          uri,
          data: data,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          options: options,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );
      } else if (e.response?.data['detail'] ==
          'No active account found with the given credentials') {
        // Handle invalid credentials error
        throw Exception('Invalid credentials');
      }
      rethrow;
    }
  }

  Future<dynamic> get(
      String uri, {
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    return await _makeRequest(
      'GET',
      uri,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<dynamic> post(
      String uri, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    return await _makeRequest(
      'POST',
      uri,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<dynamic> put(
      String uri, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    return await _makeRequest(
      'PUT',
      uri,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<dynamic> patch(
      String uri, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    return await _makeRequest(
      'PATCH',
      uri,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<dynamic> logout(String uri) async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
  }
}
