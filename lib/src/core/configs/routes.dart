import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/auth/intro/intro_binding.dart';
import '../../features/auth/intro/intro_screen.dart';
import '../../features/auth/login/login_binding.dart';
import '../../features/auth/login/login_screen.dart';
import '../../features/auth/otp/otp_binding.dart';
import '../../features/auth/otp/otp_screen.dart';
import '../../features/auth/profile_info/profile_info_binding.dart';
import '../../features/auth/profile_info/profile_info_screen.dart';
import '../../features/auth/signup/signup_binding.dart';
import '../../features/auth/signup/signup_screen.dart';
import '../../features/home/books/books_screen.dart';
import '../../features/home/contact/contact_binding.dart';
import '../../features/home/contact/contact_screen.dart';
import '../../features/home/dashboard/dashboard.dart';
import '../../features/home/dashboard/dashboard_binding.dart';
import '../../features/home/exam_details/exam_detail_binding.dart';
import '../../features/home/exam_details/exam_detail_screen.dart';
import '../../features/home/exam_history/exam_binding.dart';
import '../../features/home/exam_history/exam_screen.dart';
import '../../features/home/homescreen/home_binding.dart';
import '../../features/home/homescreen/homescreen.dart';
import '../../features/home/library/library_binding.dart';
import '../../features/home/library/library_screen.dart';
import '../../features/home/mcq_topics/mcq_topics.dart';
import '../../features/home/mcq_topics/mcq_topics_binding.dart';
import '../../features/home/quiz/quiz_binding.dart';
import '../../features/home/quiz/quiz_screen.dart';
import '../../features/home/review/review_binding.dart';
import '../../features/home/review/review_screen.dart';
import '../../features/home/score_board/score_board.dart';
import '../../features/home/score_board/score_board_binding.dart';
import '../../features/home/subject/subjects_screen.dart';
import '../../features/home/subject_detail/subject_detail_binding.dart';
import '../../features/home/subject_detail/subject_detail_screen.dart';
import '../../features/home/term_condition/terms_screen.dart';
import '../../features/home/test_sets/test_set_binding.dart';
import '../../features/home/test_sets/test_set_screen.dart';
import '../../features/home/timer/timer_bindings.dart';
import '../../features/home/timer/timer_screen.dart';

class AppRoutes {
  static const String intro = '/intro';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String profileInfo = '/profile_info';
  static const String homeScreen = '/home_screen';
  static const String dashboard = '/dashboard';
  static const String subjects = '/subject';
  static const String mcqTopics = '/mcq_topics';
  static const String topicDetails = '/test_sets';
  static const String subjectDetails = '/subject_details';
  static const String timer = '/timer';
  static const String quiz = '/quiz';
  static const String scoreBoard = '/score_board';
  static const String review = '/review';
  static const String books = '/books';
  static const String mcqHistory = '/mcq_history';
  static const String library = '/library';
  static const String contact = '/contact';
  static const String terms = '/terms';
  static const String examDetail = '/exam_detail';

  static String getIntroRoute() => intro;
  static String getSignupRoute() => signup;
  static String getLoginRoute() => login;
  static String getOtpRoute() => otp;
  static String getProfileInfoRoute() => profileInfo;
  static String getHomeScreenRoute() => homeScreen;
  static String getDashboardRoute() => dashboard;
  static String getSubjectsRoute() => subjects;
  static String getMcqTopicsRoute() => mcqTopics;
  static String getTopicDetailRoute() => topicDetails;
  static String getSubjectDetailsRoute() => subjectDetails;
  static String getTimerRoute() => timer;
  static String getQuizRoute() => quiz;
  static String getScoreBoardRoute() => scoreBoard;
  static String getReviewScreenRoute() => review;
  static String getBooksRoute() => books;
  static String getMcqHistoryRoute() => mcqHistory;
  static String getLibraryRoute() => library;
  static String getContactRoute() => contact;
  static String getTermsRoute() => terms;
  static String getExamDetailRoute() => examDetail;

  static generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case intro:
        return GetPageRoute(
          settings: settings,
          routeName: getIntroRoute(),
          page: () => IntroScreen(),
        );
      case signup:
        return GetPageRoute(
          settings: settings,
          routeName: getSignupRoute(),
          page: () => const SignupScreen(),
        );
      case login:
        return GetPageRoute(
          settings: settings,
          routeName: getLoginRoute(),
          page: () => const LoginScreen(),
        );
      case otp:
        return GetPageRoute(
          settings: settings,
          routeName: getOtpRoute(),
          page: () => const OtpScreen(),
        );
      case profileInfo:
        return GetPageRoute(
          settings: settings,
          routeName: getProfileInfoRoute(),
          page: () => const ProfileInfoScreen(),
        );
      case homeScreen:
        return GetPageRoute(
          settings: settings,
          routeName: getHomeScreenRoute(),
          page: () => const HomeScreen(),
        );
      case dashboard:
        return GetPageRoute(
          settings: settings,
          routeName: getDashboardRoute(),
          page: () => Dashboard(),
        );
      case subjects:
        return GetPageRoute(
          settings: settings,
          routeName: getSubjectsRoute(),
          page: () => const SubjectsScreen(),
        );
      case mcqTopics:
        return GetPageRoute(
          settings: settings,
          routeName: getMcqTopicsRoute(),
          page: () => const McqTopicsScreen(),
        );
      case topicDetails:
        return GetPageRoute(
          settings: settings,
          routeName: getTopicDetailRoute(),
          page: () => const TestSetScreen(title: ""),
        );
      case subjectDetails:
        return GetPageRoute(
          settings: settings,
          routeName: getSubjectDetailsRoute(),
          page: () => const SubjectDetailsScreen(title: ""),
        );
      case timer:
        return GetPageRoute(
          settings: settings,
          routeName: getTimerRoute(),
          page: () => const TimerScreen(),
        );
      case quiz:
        return GetPageRoute(
          settings: settings,
          routeName: getQuizRoute(),
          page: () => const QuizScreen(),
        );
      case scoreBoard:
        return GetPageRoute(
          settings: settings,
          routeName: getScoreBoardRoute(),
          page: () => const ScoreBoardScreen(),
        );
      case review:
        return GetPageRoute(
          settings: settings,
          routeName: getReviewScreenRoute(),
          page: () => const ReviewScreen(),
        );
      case books:
        return GetPageRoute(
          settings: settings,
          routeName: getBooksRoute(),
          page: () => BooksScreen(),
        );
      case mcqHistory:
        return GetPageRoute(
          settings: settings,
          routeName: getMcqHistoryRoute(),
          page: () => ExamsScreen(),
        );
      case library:
        return GetPageRoute(
          settings: settings,
          routeName: getLibraryRoute(),
          page: () => LibraryScreen(),
        );
      case contact:
        return GetPageRoute(
          settings: settings,
          routeName: getContactRoute(),
          page: () => const ContactScreen(),
        );
      case terms:
        return GetPageRoute(
          settings: settings,
          routeName: getTermsRoute(),
          page: () => TermsScreen(),
        );
      case examDetail:
        return GetPageRoute(
          settings: settings,
          routeName: getExamDetailRoute(),
          page: () => const ExamDetailScreen(),
        );
      default:
        return null;
    }
  }

  static getPages() => [
        GetPage(
          name: intro,
          page: () => IntroScreen(),
          binding: IntroBinding(),
        ),
        GetPage(
          name: signup,
          page: () => const SignupScreen(),
          binding: SignupBinding(),
        ),
        GetPage(
          name: login,
          page: () => const LoginScreen(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: otp,
          page: () => const OtpScreen(),
          binding: OtpBindings(),
        ),
        GetPage(
          name: profileInfo,
          page: () => const ProfileInfoScreen(),
          binding: ProfileInfoBinding(),
        ),
        GetPage(
          name: homeScreen,
          page: () => const HomeScreen(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: dashboard,
          page: () => Dashboard(),
          binding: DashboardBinding(),
        ),
        GetPage(
          name: subjects,
          page: () => const SubjectsScreen(),
          // binding: SubjectsBinding(),
        ),
        GetPage(
          name: mcqTopics,
          page: () => const McqTopicsScreen(),
          binding: McqTopicsBinding(),
        ),
        GetPage(
          name: topicDetails,
          page: () => const TestSetScreen(title: ""),
          binding: TestSetBinding(),
        ),
        GetPage(
          name: subjectDetails,
          page: () => const SubjectDetailsScreen(title: ""),
          binding: SubjectDetailsBinding(),
        ),
        GetPage(
          name: timer,
          page: () => const TimerScreen(),
          binding: TimerBinding(),
        ),
        GetPage(
          name: quiz,
          page: () => const QuizScreen(),
          binding: QuizBinding(),
        ),
        GetPage(
          name: scoreBoard,
          page: () => const ScoreBoardScreen(),
          binding: ScoreBoardBinding(),
        ),
        GetPage(
          name: review,
          page: () => const ReviewScreen(),
          binding: ReviewBinding(),
        ),
        GetPage(
          name: books,
          page: () => BooksScreen(),
          // binding: BooksBinding(),
        ),
        GetPage(
          name: mcqHistory,
          page: () => ExamsScreen(),
          binding: ExamsBinding(),
        ),
        GetPage(
          name: library,
          page: () => LibraryScreen(),
          binding: LibraryBinding(),
        ),
        GetPage(
          name: contact,
          page: () => const ContactScreen(),
          binding: ContactBinding(),
        ),
        GetPage(
          name: terms,
          page: () => TermsScreen(),
          binding: null,
        ),
        GetPage(
          name: examDetail,
          page: () => const ExamDetailScreen(),
          binding: ExamDetailBinding(),
        ),
      ];
}
