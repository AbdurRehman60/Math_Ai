


import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constant_exports.dart';
import 'endpoints.dart';

class DioClient {
  DioClient() {
    _dio.interceptors.add(CookieManager(cookieJar));
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
  ));

  final cookieJar = CookieJar();
  final _storage = const FlutterSecureStorage();

  // Retrieve access token from secure storage
  Future<String?> _getToken() async {
    final token = await _storage.read(key: 'access_token');
    // print('Retrieved access token: $token');
    return token;
  }

  // Save access token to secure storage
  Future<void> _saveToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
    // print('Access token saved: $token');
  }

  // Refresh the access token using the refresh token
  Future<void> _refreshToken() async {
    // print('Refresh token process started');
    final refreshToken = await _storage.read(key: 'refresh_token');
    // print('Retrieved refresh token: $refreshToken');

    if (refreshToken == null) {
      throw Exception('Refresh token not available');
    }

    try {
      final response = await _dio.post(
        'authentication/token/refresh',
        data: {'refresh': refreshToken},
      );
      final newToken = response.data['access'];
      // print('New access token retrieved: $newToken');
      await _saveToken(newToken);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        // print('Token refresh failed: ${e.message}');
        throw Exception('Token expired, redirect to login');
      } else {
        // print('Error refreshing token: ${e.message}');
        rethrow;
      }
    }
  }

  // Check if token is expired using jwt_decoder
  bool _isTokenExpired(String token) {
    try {
      bool isExpired = JwtDecoder.isExpired(token);
      // print('Is access token expired? $isExpired');
      return isExpired;
    } catch (e) {
      // print('Error decoding token: $e');
      return true;
    }
  }

  // Save cookies to SharedPreferences
  Future<void> _saveCookies(List<Cookie> cookies) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      'cookies',
      cookies.map((cookie) => cookie.toString()).toList(),
    );
    // print('Cookies saved: $cookies');
  }

  // Load cookies from SharedPreferences
  Future<List<Cookie>> _loadCookies() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? cookieStrings = prefs.getStringList('cookies');
    if (cookieStrings != null) {
      // print('Cookies loaded: $cookieStrings');
      return cookieStrings
          .map((cookieString) => Cookie.fromSetCookieValue(cookieString))
          .toList();
    } else {
      // print('No cookies found');
      return [];
    }
  }

  // Make a request (GET, POST, etc.) with token handling
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
    String? token = await _getToken();

    // If token exists and is expired, refresh it before making a request
    if (token != null && _isTokenExpired(token)) {
      // print('Access token is expired, refreshing...');
      await _refreshToken();
      token = await _getToken();
    }

    options ??= Options(method: method);
    options.headers ??= {};
    if (token != null) {
      options.headers!['Authorization'] = 'JWT $token';
    }

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
      final List<Cookie> cookies = await cookieJar.loadForRequest(response.requestOptions.uri);
      if (cookies.isNotEmpty) {
        await _saveCookies(cookies);
      }

      return response;
    } on DioException catch (e) {
      // Handle 401 errors for invalid credentials or expired tokens
      if (e.response?.statusCode == 401) {
        if (e.response?.data['detail'] == 'No active account found with the given credentials') {
          // print('Invalid credentials');
          throw Exception('Invalid credentials');
        } else {
          // Token might be expired, attempt to refresh
          // print('Token expired, attempting refresh...');
          await _refreshToken();  // Refresh the token
          token = await _getToken();  // Get the new token

          // Retry the original request with the refreshed token
          options.headers!['Authorization'] = 'JWT $token';
          return await _dio.request(
            uri,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          );
        }
      }
      rethrow;
    }
  }

  // GET request
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

  // POST request
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

  // PUT request
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

  // PATCH request
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

  // Logout and remove tokens
  Future<dynamic> logout(String uri) async {
    // print('Logging out...');
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
    // print('Tokens removed');
  }
}
