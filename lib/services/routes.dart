import 'package:event_app/screens/signup_screen.dart';
import 'package:get/get.dart';
import '../navbar.dart';
import '../screens/create_event_screen.dart';
import '../screens/create_post_screen.dart';
import '../screens/event_details_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/signin_screen.dart';

class Routes {
  static String navbar = '/navbar';
  static String homeScreen = '/';
  static String signinScreen = '/signin';
  static String signupScreen = '/signup';
  static String profileScreen = '/profile';
  static String eventDetailsScreen = '/event';
  static String createEventScreen = '/createEvent';
  static String createPostScreen = '/createPost';
}

final getPages = [
  GetPage(name: Routes.navbar, page: () => NavbarScreen()),
  GetPage(name: Routes.signinScreen, page: () => SignInScreen()),
  GetPage(name: Routes.homeScreen, page: () => HomeScreen()),
  GetPage(name: Routes.signupScreen, page: () => SignUpScreen()),
  GetPage(name: Routes.profileScreen, page: () => ProfileScreen()),
  GetPage(name: Routes.eventDetailsScreen, page: () => EventDetailsScreen()),
  GetPage(name: Routes.createEventScreen, page: () => CreateEventScreen()),
  GetPage(name: Routes.createPostScreen, page: () => CreatePostScreen()),
];
