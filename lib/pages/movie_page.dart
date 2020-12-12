import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/models/movie_model.dart';
import '../core/constants.dart';
import 'movie_detail_page.dart';
import '../widgets/centered_message.dart';
import '../widgets/centered_progress.dart';
import '../widgets/movie_card.dart';
import '../controllers/movie_controller.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final _controller = MovieController();
  final _pagingController = PagingController<int, MovieModel>(
    firstPageKey: 1,
  );
  int lastPage = 1;

  @override
  void initState() {
    super.initState();
    _initScrollListener();
    _initialize();
  }

  _initScrollListener() {
    _pagingController.addPageRequestListener((pageKey) async {
      await _controller.fetchAllMovies(page: pageKey);
      if (pageKey == _controller.totalPages) {
        _pagingController.appendLastPage(_controller.movies);
      } else {
        _pagingController.appendPage(_controller.movies, pageKey + 1);
      }
    });
  }

  _initialize() async {
    setState(() {
      _controller.loading = true;
    });

    await _controller.fetchAllMovies(page: lastPage);

    setState(() {
      _controller.loading = false;
    });
  }

  _initializeCrossAxis() async {
    setState(() {
      if (_controller.crossAxisCount == 2) {
        _controller.crossAxisCount = 3;
      } else {
        _controller.crossAxisCount = 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildMovieGrid(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Text(kAppName),
      actions: [
        IconButton(icon: Icon(Icons.refresh), onPressed: _initialize),
        IconButton(
          icon: Icon(Icons.grid_on),
          onPressed: _initializeCrossAxis,
        ),
      ],
    );
  }

  _buildMovieGrid() {
    if (_controller.loading) {
      return CenteredProgress();
    }

    if (_controller.movieError != null) {
      return CenteredMessage(message: _controller.movieError.message);
    }

    return PagedGridView<int, MovieModel>(
      pagingController: _pagingController,
      padding: const EdgeInsets.all(2.0),
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: _buildMovieCard,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _controller.crossAxisCount,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 0.65,
      ),
    );
  }

  Widget _buildMovieCard(context, movie, index) {
    return MovieCard(
      posterPath: movie.posterPath,
      onTap: () => _openDetailPage(movie.id),
    );
  }

  _openDetailPage(movieId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailPage(movieId),
      ),
    );
  }
}
