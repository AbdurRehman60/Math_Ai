// import '../../constants/constant_exports.dart';
// import '../../widgets/global_widgets/custom_button.dart';
// import '../../widgets/global_widgets/custom_textfield.dart';
// import '../../widgets/global_widgets/or_divider.dart';
//
// class LoginScreen extends StatelessWidget {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: ConstrainedBox(
//           constraints: BoxConstraints(
//             minHeight: MediaQuery.of(context).size.height, // Ensure minimum height is the screen size
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 80), // Space from top
//
//                 // Logo
//                 Image.asset(
//                   MathAssets.logo, // Your logo asset here
//                   height: 44,
//                   width: 44,
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Welcome Text
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Welcome back!',
//                       style: MathTextTheme()
//                           .body
//                           .copyWith(fontSize: 37, fontWeight: FontWeight.w500),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Start learning math with a love and without fear.',
//                         style: MathTextTheme().subtext.copyWith(
//                             fontSize: 14,
//                             fontWeight: FontWeights.light,
//                             color: MathColorTheme().lightBlack),
//                         textAlign: TextAlign.start,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 40),
//
//                 // Form
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       CustomTextField(
//                         filled: true,
//                         fillColor: MathColorTheme().lightGray,
//                         controller: _emailController,
//                         cursorColor: MathColorTheme().green,
//                         hintText: 'Email',
//                         hintStyle: MathTextTheme().body.copyWith(
//                             fontSize: 14,
//                             color: MathColorTheme()
//                                 .lightBlack
//                                 .withOpacity(0.5),
//                             fontWeight: FontWeights.medium),
//                         prefixIcon: Padding(
//                           padding: const EdgeInsets.all(3.0),
//                           child: Container(
//                             padding: const EdgeInsets.all(8.0),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(5.5),
//                               border: Border.all(
//                                 color: MathColorTheme().lightGray,
//                               ),
//                             ),
//                             child: Image.asset(
//                               MathAssets.profile,
//                               height: 20,
//                               width: 20,
//                             ),
//                           ),
//                         ),
//                         keyboardType: TextInputType.emailAddress,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your email';
//                           }
//                           return null;
//                         },
//                       ),
//
//                       const SizedBox(height: 16),
//
//                       CustomTextField(
//                         filled: true,
//                         fillColor: MathColorTheme().lightGray,
//                         controller: _passwordController,
//                         obscureText: true,
//                         hintStyle: MathTextTheme().body.copyWith(
//                             fontSize: 14,
//                             color: MathColorTheme()
//                                 .lightBlack
//                                 .withOpacity(0.5),
//                             fontWeight: FontWeights.medium),
//                         hintText: 'Password',
//                         prefixIcon: Padding(
//                           padding: const EdgeInsets.all(3.0),
//                           child: Container(
//                             padding: const EdgeInsets.all(8.0),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(5.5),
//                               border: Border.all(
//                                 color: MathColorTheme().lightGray,
//                               ),
//                             ),
//                             child: Image.asset(
//                               MathAssets.lock,
//                               height: 20,
//                               width: 20,
//                             ),
//                           ),
//                         ),
//                         suffixIcon: GestureDetector(
//                           onTap: () {
//                           },
//                           child: const Icon(Icons.visibility),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your password';
//                           }
//                           return null;
//                         },
//                       ),
//
//                       const SizedBox(height: 8),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: TextButton(
//                           onPressed: () {
//                           },
//                           child: Text(
//                             'Forgot password?',
//                             style: MathTextTheme().body.copyWith(
//                                 color: MathColorTheme().green,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 14
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       const SizedBox(height: 24),
//
//                       // Login Button
//                       CustomButton(
//                         title: 'Login',
//                         onTap: () {
//                           Navigator.pushNamed(context, '/reset');
//                           if (_formKey.currentState!.validate()) {
//                           }
//                         },
//                       ),
//                       SizedBoxes.verticalGargangua,
//                       const OrDivider(),
//                       SizedBoxes.verticalGargangua,
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           // Google Button
//                           Expanded(
//                             child: SizedBox(
//                               height: 50,
//                               child: ElevatedButton.icon(
//                                 style: ElevatedButton.styleFrom(
//                                   elevation: 0,
//                                   backgroundColor: MathColorTheme().white,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                     side: BorderSide(
//                                       color: MathColorTheme().gray,
//                                       width: 1.0,
//                                     ),
//                                   ),
//                                 ),
//                                 onPressed: () {
//
//                                 },
//                                 icon: Image.asset(
//                                     MathAssets.google, height: 24),
//                                 label: Text(
//                                   'Google',
//                                   style: MathTextTheme().body.copyWith(
//                                       color: Colors.black, fontWeight: FontWeight.w500),
//                                 ),
//                               ),
//                             ),
//                           ),
//
//                           const SizedBox(width: 16),
//
//                           // Facebook Button
//                           Expanded(
//                             child: SizedBox(
//                               height: 50,
//                               child: ElevatedButton.icon(
//                                 style: ElevatedButton.styleFrom(
//                                   elevation: 0,
//                                   backgroundColor: MathColorTheme().white,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                     side: BorderSide(
//                                       color: MathColorTheme().gray,
//                                       width: 1.0,
//                                     ),
//                                   ),
//                                 ),
//                                 onPressed: () {
//
//                                 },
//                                 icon: Image.asset(
//                                     MathAssets.facebook, height: 24), // Facebook logo
//                                 label: Text(
//                                   'Facebook',
//                                   style: MathTextTheme().body.copyWith(
//                                       color: Colors.black, fontWeight: FontWeight.w500),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBoxes.verticalGargangua,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Already have an account? ",
//                       style: MathTextTheme().subtext.copyWith(color: MathColorTheme().neutral400,fontSize: 14),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                       },
//                       child: Text(
//                         'Sign In',
//                         style: TextStyle(
//                             color: MathColorTheme().green,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16), // Replacing Spacer with a fixed size
//                 // Footer
//                 Text(
//                   "© Bienvenue 2024 All rights reserved",
//                   style: MathTextTheme()
//                       .subtext
//                       .copyWith(color: MathColorTheme().neutral400),
//                 ),
//                 const SizedBox(height: 16),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


//
//
// import 'package:flutter/material.dart';
// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:mathematics_ai/constants/color_theme.dart';
//
// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});
//
//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }
//
// class _BottomNavBarState extends State<BottomNavBar> {
//   int _bottomNavIndex = 0; // Current selected index for navigation
//
//   final List<Widget> _screens = [
//     const HomeScreen(),     // Index 0
//     const CoursesScreen(),  // Index 1 (for FAB)
//     const ProfileScreen(),  // Index 2
//   ];
//
//   // List of icons for the AnimatedBottomNavigationBar (Home and Profile)
//   final iconList = <IconData>[
//     Icons.home,    // Home icon at index 0
//     Icons.person,  // Profile icon at index 2
//   ];
//
//   // Function to get background color based on the current screen
//   Color _getBackgroundColor() {
//     switch (_bottomNavIndex) {
//       case 0:
//         return Colors.green[100]!;  // Home screen color
//       case 1:
//         return Colors.blue[100]!;   // Courses screen color (when FAB is pressed)
//       case 2:
//         return Colors.pink[100]!;   // Profile screen color
//       default:
//         return Colors.white;        // Default color
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Dynamically set background color based on the current screen
//       backgroundColor: _getBackgroundColor(),
//
//       body: Column(
//         children: [
//           Expanded(
//             child: IndexedStack(
//               index: _bottomNavIndex,
//               children: _screens,
//             ),
//           ),
//         ],
//       ),
//
//       // The floating action button in the center
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.green,
//         shape: const CircleBorder(), // Ensures the button is circular
//         child: const Icon(Icons.book_outlined, color: Colors.white),
//         onPressed: () {
//           setState(() {
//             _bottomNavIndex = 1; // Switch to Courses tab when FAB is pressed
//           });
//         },
//       ),
//
//       // Place the FAB in the center of the bottom navigation bar
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//
//       // Bottom navigation bar with icons and center gap for FAB
//       bottomNavigationBar: AnimatedBottomNavigationBar(
//         icons: iconList,
//         activeIndex: _bottomNavIndex == 1 ? -1 : _bottomNavIndex, // FAB should not affect other tabs
//         gapLocation: GapLocation.center, // Center gap for FAB
//         notchSmoothness: NotchSmoothness.softEdge, // Smooth notch for FAB
//         backgroundColor: _getBackgroundColor(), // Dynamic background color for the navigation bar
//         activeColor: Colors.green, // Active color for selected icons
//         inactiveColor: Colors.grey, // Inactive color for unselected icons
//         onTap: (index) {
//           setState(() {
//             if (index == 0) {
//               _bottomNavIndex = 0;  // Show Home screen when Home button is pressed
//             } else if (index == 1) {
//               _bottomNavIndex = 2;  // Show Profile screen when Profile button is pressed
//             }
//           });
//         },
//         splashSpeedInMilliseconds: 300,
//       ),
//     );
//   }
// }
//
// // Home Screen Widget
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green[100],
//       body: const Center(
//         child: Text(
//           'Home',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }
//
// // Courses Screen Widget
// class CoursesScreen extends StatelessWidget {
//   const CoursesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue[100],
//       body: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.book_outlined,
//               size: 80,
//               color: Colors.black,
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Course lesson',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 24.0),
//               child: Text(
//                 'Lorem ipsum dolor sit amet consectetur. '
//                     'Sit mattis erat id aliquet cras quam ultrices.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Profile Screen Widget
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.pink[100],
//       body: const Center(
//         child: Text(
//           'Profile',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }


// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:mathematics_ai/api_manager/endpoints.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../constants/constant_exports.dart';
//
// class DioClient {
//   DioClient() {
//     _dio.interceptors.add(CookieManager(cookieJar));
//     _dio.interceptors.add(LogInterceptor(responseBody: true));
//   }
//
//   final Dio _dio = Dio(BaseOptions(
//     baseUrl: Endpoints.serverURL,
//     connectTimeout: Endpoints.connectionTimeout,
//     receiveTimeout: Endpoints.connectionTimeout,
//     headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     },
//   ));
//
//   final cookieJar = CookieJar();
//   final _storage = const FlutterSecureStorage();
//
//   // Retrieve access token from secure storage
//   Future<String?> _getToken() async {
//     final token = await _storage.read(key: 'access_token');
//     print('Retrieved access token: $token');
//     return token;
//   }
//
//   // Save access token to secure storage
//   Future<void> _saveToken(String token) async {
//     await _storage.write(key: 'access_token', value: token);
//     print('Access token saved: $token');
//   }
//
//   // Refresh the access token using the refresh token
//   Future<void> _refreshToken() async {
//     print('Refresh token process started');
//     final refreshToken = await _storage.read(key: 'refresh_token');
//     print('Retrieved refresh token: $refreshToken');
//
//     if (refreshToken == null) {
//       throw Exception('Refresh token not available');
//     }
//
//     try {
//       final response = await _dio.post(
//         'authentication/token/refresh',
//         data: {'refresh': refreshToken},
//       );
//       final newToken = response.data['access'];
//       print('New access token retrieved: $newToken');
//       await _saveToken(newToken);
//     } on DioError catch (e) {
//       if (e.response?.statusCode == 401) {
//         print('Token refresh failed: ${e.message}');
//         throw Exception('Token expired, redirect to login');
//       } else {
//         print('Error refreshing token: ${e.message}');
//         throw e;
//       }
//     }
//   }
//
//   // Save cookies to SharedPreferences
//   Future<void> _saveCookies(List<Cookie> cookies) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setStringList(
//       'cookies',
//       cookies.map((cookie) => cookie.toString()).toList(),
//     );
//     print('Cookies saved: $cookies');
//   }
//
//   // Load cookies from SharedPreferences
//   Future<List<Cookie>> _loadCookies() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final List<String>? cookieStrings = prefs.getStringList('cookies');
//     if (cookieStrings != null) {
//       print('Cookies loaded: $cookieStrings');
//       return cookieStrings
//           .map((cookieString) => Cookie.fromSetCookieValue(cookieString))
//           .toList();
//     } else {
//       print('No cookies found');
//       return [];
//     }
//   }
//
//   // Make a request (GET, POST, etc.) with token handling
//   Future<Response> _makeRequest(
//       String method,
//       String uri, {
//         dynamic data,
//         Map<String, dynamic>? queryParameters,
//         CancelToken? cancelToken,
//         Options? options,
//         ProgressCallback? onSendProgress,
//         ProgressCallback? onReceiveProgress,
//       }) async {
//     final String? token = await _getToken();
//     print('Using access token: $token');
//
//     options ??= Options(method: method);
//     options.headers ??= {};
//     options.headers!['Authorization'] = 'JWT $token';
//
//     try {
//       final response = await _dio.request(
//         uri,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//         onSendProgress: onSendProgress,
//         onReceiveProgress: onReceiveProgress,
//       );
//
//       // Save cookies after the request
//       final List<Cookie> cookies =
//       await cookieJar.loadForRequest(response.requestOptions.uri);
//       if (cookies.isNotEmpty) {
//         await _saveCookies(cookies);
//       }
//
//       return response;
//     } on DioError catch (e) {
//       print('Request error: ${e.message}');
//       // Handle 401 errors for invalid credentials
//       if (e.response?.statusCode == 401) {
//         if (e.response?.data['detail'] == 'No active account found with the given credentials') {
//           print('Invalid credentials');
//           throw Exception('Invalid credentials');
//         }
//       }
//       // Handle other cases
//       throw e;
//     }
//   }
//
//
//   // GET request
//   Future<dynamic> get(
//       String uri, {
//         Map<String, dynamic>? queryParameters,
//         CancelToken? cancelToken,
//         ProgressCallback? onReceiveProgress,
//       }) async {
//     return await _makeRequest(
//       'GET',
//       uri,
//       queryParameters: queryParameters,
//       cancelToken: cancelToken,
//       onReceiveProgress: onReceiveProgress,
//     );
//   }
//
//   // POST request
//   Future<dynamic> post(
//       String uri, {
//         dynamic data,
//         Map<String, dynamic>? queryParameters,
//         CancelToken? cancelToken,
//         ProgressCallback? onSendProgress,
//         ProgressCallback? onReceiveProgress,
//       }) async {
//     return await _makeRequest(
//       'POST',
//       uri,
//       data: data,
//       queryParameters: queryParameters,
//       cancelToken: cancelToken,
//       onSendProgress: onSendProgress,
//       onReceiveProgress: onReceiveProgress,
//     );
//   }
//
//   // PUT request
//   Future<dynamic> put(
//       String uri, {
//         dynamic data,
//         Map<String, dynamic>? queryParameters,
//         CancelToken? cancelToken,
//         ProgressCallback? onSendProgress,
//         ProgressCallback? onReceiveProgress,
//       }) async {
//     return await _makeRequest(
//       'PUT',
//       uri,
//       data: data,
//       queryParameters: queryParameters,
//       cancelToken: cancelToken,
//       onSendProgress: onSendProgress,
//       onReceiveProgress: onReceiveProgress,
//     );
//   }
//
//   // PATCH request
//   Future<dynamic> patch(
//       String uri, {
//         dynamic data,
//         Map<String, dynamic>? queryParameters,
//         CancelToken? cancelToken,
//         ProgressCallback? onSendProgress,
//         ProgressCallback? onReceiveProgress,
//       }) async {
//     return await _makeRequest(
//       'PATCH',
//       uri,
//       data: data,
//       queryParameters: queryParameters,
//       cancelToken: cancelToken,
//       onSendProgress: onSendProgress,
//       onReceiveProgress: onReceiveProgress,
//     );
//   }
//
//   // Logout and remove tokens
//   Future<dynamic> logout(String uri) async {
//     print('Logging out...');
//     await _storage.delete(key: 'access_token');
//     await _storage.delete(key: 'refresh_token');
//     print('Tokens removed');
//   }
// }

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mathematics_ai/api_manager/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

// class DioClient {
//   DioClient() {
//     _dio.interceptors.add(CookieManager(cookieJar));
//     _dio.interceptors.add(LogInterceptor(responseBody: true));
//   }
//
//   final Dio _dio = Dio(BaseOptions(
//     baseUrl: Endpoints.serverURL,
//     connectTimeout: Endpoints.connectionTimeout,
//     receiveTimeout: Endpoints.connectionTimeout,
//     headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     },
//   ));
//
//   final cookieJar = CookieJar();
//   final _storage = const FlutterSecureStorage();
//
//   // Retrieve access token from secure storage
//   Future<String?> _getToken() async {
//     final token = await _storage.read(key: 'access_token');
//     print('Retrieved access token: $token');
//     return token;
//   }
//
//   // Save access token to secure storage
//   Future<void> _saveToken(String token) async {
//     await _storage.write(key: 'access_token', value: token);
//     print('Access token saved: $token');
//   }
//
//   // Refresh the access token using the refresh token
//   Future<void> _refreshToken() async {
//     print('Refresh token process started');
//     final refreshToken = await _storage.read(key: 'refresh_token');
//     print('Retrieved refresh token: $refreshToken');
//
//     if (refreshToken == null) {
//       throw Exception('Refresh token not available');
//     }
//
//     try {
//       final response = await _dio.post(
//         'authentication/token/refresh',
//         data: {'refresh': refreshToken},
//       );
//       final newToken = response.data['access'];
//       print('New access token retrieved: $newToken');
//       await _saveToken(newToken);  // Save the new access token
//     } on DioError catch (e) {
//       if (e.response?.statusCode == 401) {
//         print('Token refresh failed: ${e.message}');
//         throw Exception('Token expired, redirect to login');
//       } else {
//         print('Error refreshing token: ${e.message}');
//         throw e;
//       }
//     }
//   }
//
//   // Save cookies to SharedPreferences
//   Future<void> _saveCookies(List<Cookie> cookies) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setStringList(
//       'cookies',
//       cookies.map((cookie) => cookie.toString()).toList(),
//     );
//     print('Cookies saved: $cookies');
//   }
//
//   // Load cookies from SharedPreferences
//   Future<List<Cookie>> _loadCookies() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final List<String>? cookieStrings = prefs.getStringList('cookies');
//     if (cookieStrings != null) {
//       print('Cookies loaded: $cookieStrings');
//       return cookieStrings
//           .map((cookieString) => Cookie.fromSetCookieValue(cookieString))
//           .toList();
//     } else {
//       print('No cookies found');
//       return [];
//     }
//   }
//
//   // Make a request (GET, POST, etc.) with token handling
//   Future<Response> _makeRequest(
//       String method,
//       String uri, {
//         dynamic data,
//         Map<String, dynamic>? queryParameters,
//         CancelToken? cancelToken,
//         Options? options,
//         ProgressCallback? onSendProgress,
//         ProgressCallback? onReceiveProgress,
//       }) async {
//     String? token = await _getToken();
//
//     // Add authorization header if token is available
//     options ??= Options(method: method);
//     options.headers ??= {};
//     if (token != null) {
//       options.headers!['Authorization'] = 'JWT $token';
//     }
//
//     try {
//       final response = await _dio.request(
//         uri,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//         onSendProgress: onSendProgress,
//         onReceiveProgress: onReceiveProgress,
//       );
//
//       // Save cookies after the request
//       final List<Cookie> cookies = await cookieJar.loadForRequest(response.requestOptions.uri);
//       if (cookies.isNotEmpty) {
//         await _saveCookies(cookies);
//       }
//
//       return response;
//     } on DioError catch (e) {
//       // Handle 401 Unauthorized errors
//       if (e.response?.statusCode == 401) {
//         // Check if it's due to token expiration
//         if (e.response?.data['detail'] == 'No active account found with the given credentials') {
//           print('Invalid credentials');
//           throw Exception('Invalid credentials');
//         } else {
//           // Token might be expired, attempt to refresh
//           print('Token expired, attempting refresh...');
//           await _refreshToken();
//
//           // Retry the original request with the refreshed token
//           token = await _getToken();
//           options.headers!['Authorization'] = 'JWT $token';  // Update token in headers
//
//           return await _dio.request(
//             uri,
//             data: data,
//             queryParameters: queryParameters,
//             options: options,
//             cancelToken: cancelToken,
//             onSendProgress: onSendProgress,
//             onReceiveProgress: onReceiveProgress,
//           );
//         }
//       }
//       // Handle other Dio errors
//       throw e;
//     }
//   }
//
//   // GET request
//   Future<dynamic> get(
//       String uri, {
//         Map<String, dynamic>? queryParameters,
//         CancelToken? cancelToken,
//         ProgressCallback? onReceiveProgress,
//       }) async {
//     return await _makeRequest(
//       'GET',
//       uri,
//       queryParameters: queryParameters,
//       cancelToken: cancelToken,
//       onReceiveProgress: onReceiveProgress,
//     );
//   }
//
//   // POST request
//   Future<dynamic> post(
//       String uri, {
//         dynamic data,
//         Map<String, dynamic>? queryParameters,
//         CancelToken? cancelToken,
//         ProgressCallback? onSendProgress,
//         ProgressCallback? onReceiveProgress,
//       }) async {
//     return await _makeRequest(
//       'POST',
//       uri,
//       data: data,
//       queryParameters: queryParameters,
//       cancelToken: cancelToken,
//       onSendProgress: onSendProgress,
//       onReceiveProgress: onReceiveProgress,
//     );
//   }
//
//   // PUT request
//   Future<dynamic> put(
//       String uri, {
//         dynamic data,
//         Map<String, dynamic>? queryParameters,
//         CancelToken? cancelToken,
//         ProgressCallback? onSendProgress,
//         ProgressCallback? onReceiveProgress,
//       }) async {
//     return await _makeRequest(
//       'PUT',
//       uri,
//       data: data,
//       queryParameters: queryParameters,
//       cancelToken: cancelToken,
//       onSendProgress: onSendProgress,
//       onReceiveProgress: onReceiveProgress,
//     );
//   }
//
//   // PATCH request
//   Future<dynamic> patch(
//       String uri, {
//         dynamic data,
//         Map<String, dynamic>? queryParameters,
//         CancelToken? cancelToken,
//         ProgressCallback? onSendProgress,
//         ProgressCallback? onReceiveProgress,
//       }) async {
//     return await _makeRequest(
//       'PATCH',
//       uri,
//       data: data,
//       queryParameters: queryParameters,
//       cancelToken: cancelToken,
//       onSendProgress: onSendProgress,
//       onReceiveProgress: onReceiveProgress,
//     );
//   }
//
//   // Logout and remove tokens
//   Future<dynamic> logout(String uri) async {
//     print('Logging out...');
//     await _storage.delete(key: 'access_token');
//     await _storage.delete(key: 'refresh_token');
//     print('Tokens removed');
//   }
// }

// CustomTextField(
//   filled: true,
//   fillColor: Provider.of<ThemeProvider>(context, listen: false).isDarkMode
//       ? MathColorTheme().darkScaffold.withOpacity(0.8)
//       : MathColorTheme().lightGray,
//   controller: _passwordController,
//   obscureText: true,
//   hintStyle: MathTextTheme().body.copyWith(
//     fontSize: 14,
//     color: Provider.of<ThemeProvider>(context, listen: false).isDarkMode
//         ? MathColorTheme().brownGray
//         : MathColorTheme().lightBlack.withOpacity(0.5),
//     fontWeight: FontWeights.medium,
//   ),
//   hintText: 'Password',
//   prefixIcon: Padding(
//     padding: const EdgeInsets.all(3.0),
//     child: Container(
//       padding: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(5.5),
//         border: Border.all(
//           color: Provider.of<ThemeProvider>(context, listen: false).isDarkMode
//               ? MathColorTheme().white
//               : MathColorTheme().lightBlack,
//         ),
//       ),
//       child: Image.asset(
//         MathAssets.lock, // Custom lock icon
//         height: 20,
//         width: 20,
//       ),
//     ),
//   ),
//   cursorColor: MathColorTheme().green, // Green cursor
//   validator: (value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your password';
//     }
//     return null;
//   },
// ),
