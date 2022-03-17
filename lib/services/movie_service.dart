import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:movieaddict/models/movie.dart';

// class MovieService {
//   Future<List<Movie>> fetchmovies() async {
//     var response = await rootBundle.loadString('assets/movie_output.json');
//     var jsonResponse = await json.decode(response) as List;
//     return jsonResponse.map((movie) => Movie.fromJson(movie)).toList();
//   }

// }
class MovieService {
  Stream<List<Movie>> fetchmovies() {
    return FirebaseFirestore.instance.collection('movies').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Movie.fromJson(doc.data())).toList());
  }
}
