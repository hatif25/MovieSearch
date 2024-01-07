import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/movie.dart';

class MovieSearch {
  final String primaryImage;
  final String titleText;
  final String releaseYear;

  MovieSearch({
    required this.primaryImage,
    required this.titleText,
    required this.releaseYear,
  });
}

class MovieSearchWidget extends StatelessWidget {
  final Movie movie;
  final BuildContext context;

  MovieSearchWidget({required this.movie, required this.context});

  @override
  Widget build(BuildContext context) {
    String releaseYear = movie.releaseYear.toString();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: Offset(0.0, 10.0),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          ),
        ],
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.35),
            BlendMode.color,
          ),
          image: NetworkImage(movie.primaryImage),
          fit: BoxFit.fitHeight,
          alignment: Alignment.topLeft,
        ),
      ),
      child: Stack(
        children: [
          _buildTitleText(),
          _buildReleaseYear(context), // Pass context to _buildReleaseYear
        ],
      ),
    );
  }

  Widget _buildTitleText() {
    return Align(
      child: Text(
        movie.titleText,
        style: TextStyle(
          fontSize: 17,
          color: Colors.black,
        ),
        overflow: TextOverflow.fade,
        maxLines: 4,
        textAlign: TextAlign.left,
      ),
      alignment: Constants.titleTextAlignment,
    );
  }

  Widget _buildReleaseYear(BuildContext context) {
    return Align(
      child: Container(
        width: MediaQuery.of(context).size.width * Constants.releaseYearWidthFactor,
        child: Text(
          movie.releaseYear,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            backgroundColor: Colors.white.withOpacity(0.8),
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
        ),
      ),
      alignment: Constants.releaseYearAlignment,
    );
  }
}

class Constants {
  static const titleTextAlignment = Alignment(0.6, -1.0);
  static const releaseYearAlignment = Alignment(0.9, -0.6);
  static const releaseYearWidthFactor = 0.6;
}
