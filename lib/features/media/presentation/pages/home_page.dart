import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb_flutter_app/core/router/app_router.dart';
import 'package:moviedb_flutter_app/features/media/presentation/cubit/movies_cubit.dart';
import 'package:moviedb_flutter_app/features/media/presentation/cubit/movies_state.dart';
import 'package:moviedb_flutter_app/features/media/presentation/cubit/tv_shows_cubit.dart';
import 'package:moviedb_flutter_app/features/media/presentation/cubit/tv_shows_state.dart';
import 'package:moviedb_flutter_app/features/media/presentation/widgets/error_view.dart';
import 'package:moviedb_flutter_app/features/media/presentation/widgets/media_grid.dart';
import 'package:moviedb_flutter_app/injection_container.dart';

/// Main screen showing movies and TV shows in a tabbed layout.
///
/// Each tab has two filter chips — Popular and Top Rated.
/// Cubits are provided here via GetIt and disposed automatically
/// by [BlocProvider].
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<MoviesCubit>()..fetchPopularMovies()),
        BlocProvider(create: (_) => sl<TvShowsCubit>()..fetchPopularTvShows()),
      ],
      child: const _HomeContent(),
    );
  }
}

class _HomeContent extends StatefulWidget {
  const _HomeContent();

  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  /// Tracks active filter for each tab independently.
  bool _moviesPopular = true;
  bool _tvPopular = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        title: const Text(
          'MovieDB',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, color: Colors.white),
            onPressed: () => context.push(AppRouter.search),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white12, width: 0.5),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: const Color(0xFFE50914),
              unselectedLabelColor: Colors.white54,
              // This makes the indicator span the full tab width
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 2.5,
              indicatorColor: const Color(0xFFE50914),
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: 'Películas'),
                Tab(text: 'Series'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _MoviesTab(
            isPopular: _moviesPopular,
            onFilterChanged: (popular) {
              setState(() => _moviesPopular = popular);
              if (popular) {
                context.read<MoviesCubit>().fetchPopularMovies();
              } else {
                context.read<MoviesCubit>().fetchTopRatedMovies();
              }
            },
          ),
          _TvShowsTab(
            isPopular: _tvPopular,
            onFilterChanged: (popular) {
              setState(() => _tvPopular = popular);
              if (popular) {
                context.read<TvShowsCubit>().fetchPopularTvShows();
              } else {
                context.read<TvShowsCubit>().fetchTopRatedTvShows();
              }
            },
          ),
        ],
      ),
    );
  }
}

/// Movies tab with filter chips and BlocBuilder.
class _MoviesTab extends StatelessWidget {
  const _MoviesTab({required this.isPopular, required this.onFilterChanged});

  final bool isPopular;
  final ValueChanged<bool> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FilterChips(isPopular: isPopular, onFilterChanged: onFilterChanged),
        Expanded(
          child: BlocBuilder<MoviesCubit, MoviesState>(
            builder: (context, state) {
              return state.when(
                initial: () => const SizedBox.shrink(),
                loading: () => const Center(
                  child: CircularProgressIndicator(color: Color(0xFFE50914)),
                ),
                loaded: (movies) => movies.isEmpty
                    ? const _EmptyView()
                    : MoviesGrid(movies: movies),
                error: (message) => ErrorView(
                  message: message,
                  onRetry: () => isPopular
                      ? context.read<MoviesCubit>().fetchPopularMovies()
                      : context.read<MoviesCubit>().fetchTopRatedMovies(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// TV shows tab with filter chips and BlocBuilder.
class _TvShowsTab extends StatelessWidget {
  const _TvShowsTab({required this.isPopular, required this.onFilterChanged});

  final bool isPopular;
  final ValueChanged<bool> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FilterChips(isPopular: isPopular, onFilterChanged: onFilterChanged),
        Expanded(
          child: BlocBuilder<TvShowsCubit, TvShowsState>(
            builder: (context, state) {
              return state.when(
                initial: () => const SizedBox.shrink(),
                loading: () => const Center(
                  child: CircularProgressIndicator(color: Color(0xFFE50914)),
                ),
                loaded: (tvShows) => tvShows.isEmpty
                    ? const _EmptyView()
                    : TvShowsGrid(tvShows: tvShows),
                error: (message) => ErrorView(
                  message: message,
                  onRetry: () => isPopular
                      ? context.read<TvShowsCubit>().fetchPopularTvShows()
                      : context.read<TvShowsCubit>().fetchTopRatedTvShows(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Filter chips row — Popular and Top Rated.
class _FilterChips extends StatelessWidget {
  const _FilterChips({required this.isPopular, required this.onFilterChanged});

  final bool isPopular;
  final ValueChanged<bool> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A1A2E),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          _Chip(
            label: 'Popular',
            selected: isPopular,
            onTap: () => onFilterChanged(true),
          ),
          const SizedBox(width: 8),
          _Chip(
            label: 'Mejor evaluadas',
            selected: !isPopular,
            onTap: () => onFilterChanged(false),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE50914) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? const Color(0xFFE50914)
                : Colors.white.withValues(alpha: 0.3),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected
                ? Colors.white
                : Colors.white.withValues(alpha: 0.7),
            fontSize: 13,
            fontWeight: selected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No hay contenido disponible',
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
