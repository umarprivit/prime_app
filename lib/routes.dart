import 'package:get/get.dart';
import 'package:prime_app/screens/course_screens/chapter_screen.dart';
import 'package:prime_app/screens/course_screens/quiz_note_screen.dart';
import 'package:prime_app/screens/course_screens/quiz_result_screen.dart';
import 'package:prime_app/screens/course_screens/quiz_screen.dart';
import 'package:prime_app/screens/course_screens/request_course.dart';
import 'package:prime_app/screens/course_screens/topics_screen.dart';
import 'package:prime_app/screens/course_screens/video_screen.dart';
import 'package:prime_app/screens/dashboard/homeScreen.dart';
import 'package:prime_app/screens/dashboard/dashboard_screen.dart';
import 'package:prime_app/screens/starting_screens/banners_screen.dart';
import 'package:prime_app/screens/starting_screens/intro_screen.dart';
import 'package:prime_app/screens/starting_screens/login_screen.dart';
import 'package:prime_app/screens/starting_screens/signup_screen.dart';
import 'package:prime_app/screens/starting_screens/welcome_screen.dart';

class AppRoutes {
  static List<GetPage<dynamic>> routes = [
    GetPage(
      name: Routes.BANNER_SCREEN_ROUTE,
      page: () => BannersScreen(),
    ),
    GetPage(
      name: Routes.WELCOME_SCREEN_ROUTE,
      page: () => WelcomeScreen(),
    ),
    GetPage(
      name: Routes.SIGNUP_SCREEN_ROUTE,
      page: () => SignupScreen(),
    ),
    GetPage(
      name: Routes.LOGIN_SCREEN_ROUTE,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.DASHBOARD_SCREEN_ROUTE,
      page: () => DashboardScreen(),
    ),
    GetPage(
      name: Routes.INTRO_SCREEN_ROUTE,
      page: () => IntroScreen(),
    ),
    GetPage(
      name: Routes.CHAPTER_SCREEN_ROUTE,
      page: () => ChapterScreen(),
    ),
    GetPage(
      name: Routes.TOPICS_SCREEN_ROUTE,
      page: () => TopicsScreen(),
    ),
    GetPage(
      name: Routes.VIDEO_SCREEN_ROUTE,
      page: () => YouTubePlayerScreen(),
    ),
    GetPage(
      name: Routes.QUIZ_INSTRUCTION_SCREEN_ROUTE,
      page: () => QuizInstructionsScreen(),
    ),
    GetPage(
      name: Routes.QUIZ_SCREEN_ROUTE,
      page: () => QuizScreen(),
    ),
    GetPage(
      name: Routes.QUIZ_RESULT_SCREEN_ROUTE,
      page: () => QuizResultScreen(),
    ),
    GetPage(
      name: Routes.REQUEST_COURSE_SCREEN_ROUTE,
      page: () => RequestCourse(),
    ),
  ];
}

class Routes {
  static String BANNER_SCREEN_ROUTE = '/banner_screen';
  static String WELCOME_SCREEN_ROUTE = '/welcome_screen';
  static String SIGNUP_SCREEN_ROUTE = '/signup_screen';
  static String LOGIN_SCREEN_ROUTE = '/login_screen';
  static String DASHBOARD_SCREEN_ROUTE = '/dashboard_screen';
  static String INTRO_SCREEN_ROUTE = '/intro_screen';
  static String CHAPTER_SCREEN_ROUTE = '/chapter_screen';
  static String TOPICS_SCREEN_ROUTE = '/topics_screen';
  static String VIDEO_SCREEN_ROUTE = '/video_screen';
  static String QUIZ_SCREEN_ROUTE = '/quiz_screen';
  static String QUIZ_INSTRUCTION_SCREEN_ROUTE = '/quiz_instruction_screen';
  static String QUIZ_RESULT_SCREEN_ROUTE = '/quiz_result_screen';
  static String REQUEST_COURSE_SCREEN_ROUTE = '/course_request_screen';
}

class Endpoints {}
