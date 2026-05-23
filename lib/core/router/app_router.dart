import 'package:go_router/go_router.dart';
import 'package:moviedb_flutter_app/features/media/presentation/pages/detail_page.dart';
import 'package:moviedb_flutter_app/features/media/presentation/pages/home_page.dart';
import 'package:moviedb_flutter_app/features/media/presentation/pages/search_page.dart';

/// Application router configuration using go_router.
///
/// Defines all named routes and their associated pages.
/// Extra data is passed via [GoRouterState.extra] to avoid
/// exposing IDs in the URL path for internal navigation.
class AppRouter {
  AppRouter._();

  /// Named route identifiers.
  static const String home = '/';
  static const String detail = '/detail';
  static const String search = '/search';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: detail,
        /// Expects a [MediaDetail] object passed via extra.
        /// The detail page uses this to display content immediately
        /// while fetching full detail from the API.
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return DetailPage(
            id: extra['id'] as int,
            isMovie: extra['isMovie'] as bool,
          );
        },
      ),
      GoRoute(
        path: search,
        builder: (context, state) => const SearchPage(),
      ),
    ],
  );
}