import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import '../../../../core/database/database_helper.dart';
import '../models/movie_details_dto.dart';
import '../models/credits_dto.dart';

class MovieDetailsLocalDataSource {
  final DatabaseHelper _dbHelper;

  MovieDetailsLocalDataSource(this._dbHelper);

  /// Cache movie details and credits
  Future<void> cacheMovieDetails(
    MovieDetailsDto details,
    CreditsDto credits,
  ) async {
    final db = await _dbHelper.database;

    await db.insert(
      'movie_details',
      {
        'id': details.id,
        'data': jsonEncode({
          'details': details.toJson(),
          'credits': credits.toJson(),
        }),
        'cached_at': DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get cached movie details
  Future<(MovieDetailsDto, CreditsDto)?> getCachedMovieDetails(
    int movieId,
  ) async {
    final db = await _dbHelper.database;

    final results = await db.query(
      'movie_details',
      where: 'id = ?',
      whereArgs: [movieId],
    );

    if (results.isEmpty) return null;

    final data = jsonDecode(results.first['data'] as String);
    final details = MovieDetailsDto.fromJson(data['details']);
    final credits = CreditsDto.fromJson(data['credits']);

    return (details, credits);
  }

  /// Clear old cached movie details (older than 7 days)
  Future<void> clearOldCache() async {
    final db = await _dbHelper.database;
    final sevenDaysAgo =
        DateTime.now().subtract(const Duration(days: 7)).millisecondsSinceEpoch;

    await db.delete(
      'movie_details',
      where: 'cached_at < ?',
      whereArgs: [sevenDaysAgo],
    );
  }
}
