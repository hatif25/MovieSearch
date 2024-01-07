import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/movie.dart';
import 'package:flutter_application_1/services/search_service.api.dart';
import 'package:flutter_application_1/widget/search_results.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final SearchResultApi searchApi;

  CustomSearchDelegate({required this.searchApi});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          // Clear the search bar.
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
      // Exit from the search screen.
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResults(context, searchApi.search(query));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  Widget _buildResults(BuildContext context, Future<List<Movie>> searchResults) {
    return FutureBuilder<List<Movie>>(
      future: searchResults,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final List<Movie> movies = snapshot.data ?? [];

          if (movies.isEmpty) {
            return Text('No results found.');
          }

          return _buildMovieSearchWidgets(context, movies);
        }
      },
    );
  }

  Widget _buildMovieSearchWidgets(BuildContext context, List<Movie> movieSearchResults) {
    return ListView.builder(
      itemCount: movieSearchResults.length,
      itemBuilder: (context, index) {
        return MovieSearchWidget(movie: movieSearchResults[index], context: context);
      },
    );
  }
}

