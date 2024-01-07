import 'package:dio/dio.dart';
import 'package:flutter_application_1/model/movie.dart';

class SearchResultApi {
  final String apiKey;
  final String apiUrl;
  final Dio dio;

  SearchResultApi({required this.apiKey, required this.apiUrl}) : dio = Dio();

  Future<List<Movie>> search(String query) async {
    try {
      final response = await dio.get(
        'https://moviesdatabase.p.rapidapi.com/titles/search/title/%7Btitle%7D',
        queryParameters: {
          'exact': 'true',
          'titleType': 'movie',
          'query': query,
        },
        options: Options(
          headers: {
            'X-RapidAPI-Key': 'dfc5d7498amsh7ede97992791989p1ec447jsn8bdb681153f5',
            'X-RapidAPI-Host': 'moviesdatabase.p.rapidapi.com',
          },
        ),
      );

      // Check if 'results' key is present and is a List
      final List<dynamic>? results = response.data?['results'];

      if (results != null && results.isNotEmpty) {
        // Extracting the first result
        final Map<String, dynamic> movieData = results[0];

        // Extract image details
        final Map<String, dynamic> imageDetails = movieData['primaryImage'];

        // Convert data to Movie object
        Movie movie = Movie(
          primaryImage: imageDetails['url'],
          titleText: movieData['titleText']['text'],
          releaseYear: movieData['releaseYear']['year'].toString(),
        );

        return [movie];
      } else {
        // Handle the case when no results are found
        return [];
      }
    } catch (error) {
      throw Exception('Dio error: $error');
    }
  }
}
