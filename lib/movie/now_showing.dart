import 'dart:convert';
import 'package:http/http.dart' as http;

class Movies {
  final int imdbId;
  final String poster;
  final String title;
  final String year;
  // ignore: non_constant_identifier_names
  final double vote_average;
  final String overview;

  Movies(
      {required this.imdbId,
      required this.title,
      required this.poster,
      required this.year,
      // ignore: non_constant_identifier_names
      required this.vote_average,
      required this.overview});

  factory Movies.fromJson(Map<String, dynamic> json) {
    return Movies(
        imdbId: json["id"],
        poster: "https://www.themoviedb.org/t/p/w533_and_h300_bestv2" +
            json["backdrop_path"],
        title:
            json["title"].toString() == "null" ? json["name"] : json["title"],
        year: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2" +
            json["poster_path"],
        vote_average: json["vote_average"],
        overview: json["overview"]);
  }
}

Future<List<Movies>>? fetchAllMovies() async {
  final response = await http.get(Uri.parse(
      "https://api.themoviedb.org/3/trending/all/day?api_key=f45ed86c0a3a4ffa16e3d9f8118fc6f8"));

  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result["results"];
    return list.map((movie) => Movies.fromJson(movie)).toList();
  } else {
    throw Exception("Failed to load movies!");
  }
}
/*import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class Movies {
  final Dio _dio = Dio();
  final int imdbId;
  final String poster;
  final String title;
  final String year;
  // ignore: non_constant_identifier_names
  final double vote_average;
  final String overview;
  final String youtube;

  Movies(
      {this.imdbId,
      this.title,
      this.poster,
      this.year,
      // ignore: non_constant_identifier_names
      this.vote_average,
      this.overview,
      this.youtube});

  factory Movies.fromJson(Map<String, dynamic> json) {
    return Movies(
      imdbId: json["id"],
      poster: "https://www.themoviedb.org/t/p/w533_and_h300_bestv2" +
          json["backdrop_path"],
      title: json["title"].toString() == "null" ? json["name"] : json["title"],
      year: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2" +
          json["poster_path"],
      vote_average: json["vote_average"],
      overview: json["overview"],
      youtube: json["overview"],
    );
  }
}



Future<List<Movies>>? fetchAllMovies() async {
  final response = await http.get(Uri.parse(
      "https://api.themoviedb.org/3/trending/all/day?api_key=f45ed86c0a3a4ffa16e3d9f8118fc6f8"));

  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result["results"];
    return list.map((movie) => Movies.fromJson(movie)).toList();
  } else {
    throw Exception("Failed to load movies!");
  }
}

Future<String> getYoutubeId(int id) async {
  Dio _dio = Dio();
  try {
    final response = await _dio.get(
        'https://api.themoviedb.org/3//movie/$id?f45ed86c0a3a4ffa16e3d9f8118fc6f8');
    var youtubeId = response.data['results'][0]['key'];
    return youtubeId;
  } catch (error, stacktrace) {
    throw Exception('Exception accoured: $error with stacktrace: $stacktrace');
  }
}
 */