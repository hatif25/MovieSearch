import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/search_service.api.dart';
import 'package:flutter_application_1/views/home.dart';

void main() {
  final SearchResultApi searchApi = SearchResultApi(
    apiKey: 'dfc5d7498amsh7ede97992791989p1ec447jsn8bdb681153f5',
    apiUrl: 'https://moviesdatabase.p.rapidapi.com/titles/search/title/%7Btitle%7D',
  );

  runApp(MyApp(searchApi: searchApi));
}

class MyApp extends StatelessWidget {
  final SearchResultApi searchApi;

  const MyApp({Key? key, required this.searchApi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Movie'),
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            child: const Icon(Icons.search),
            onPressed: () async {
              await showSearch(
                context: context,
                delegate: CustomSearchDelegate(searchApi: searchApi),
              );
            },
          ),
        ),
      ),
    );
  }
}
