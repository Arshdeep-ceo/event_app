import 'package:event_app/screens/signup_screen.dart';
import 'package:get/get.dart';
import '../navbar.dart';
import '../screens/create_event_screen.dart';
import '../screens/create_post_screen.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/event_details_screen.dart';
import '../screens/home_screen.dart';
import '../screens/participation_form_screen.dart';
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
  static String editProfileScreen = '/editProfile';
  static String participationFormScreen = '/participationForm';
}

final getPages = [
  GetPage(name: Routes.navbar, page: () => const NavbarScreen()),
  GetPage(name: Routes.signinScreen, page: () => const SignInScreen()),
  GetPage(name: Routes.homeScreen, page: () => const HomeScreen()),
  GetPage(name: Routes.signupScreen, page: () => const SignUpScreen()),
  GetPage(
      name: Routes.participationFormScreen,
      page: () => const ParticipationFormScreen()),
  GetPage(
      name: Routes.editProfileScreen, page: () => const EditProfileScreen()),
  GetPage(name: Routes.profileScreen, page: () => const ProfileScreen()),
  GetPage(
      name: Routes.eventDetailsScreen, page: () => const EventDetailsScreen()),
  GetPage(
      name: Routes.createEventScreen, page: () => const CreateEventScreen()),
  GetPage(name: Routes.createPostScreen, page: () => const CreatePostScreen()),
];
