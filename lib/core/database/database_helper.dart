import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Database helper for local movie caching
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'movies.db');

    return await openDatabase(
      path,
      version: 2, // Increment version for schema change
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE movies (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        overview TEXT,
        poster_path TEXT,
        backdrop_path TEXT,
        vote_average REAL,
        vote_count INTEGER,
        release_date TEXT,
        genre_ids TEXT,
        page INTEGER NOT NULL,
        category TEXT NOT NULL,
        cached_at INTEGER NOT NULL
      )
    ''');

    // Create metadata table for storing pagination info
    await db.execute('''
      CREATE TABLE movies_metadata (
        category TEXT NOT NULL,
        page INTEGER NOT NULL,
        total_pages INTEGER NOT NULL,
        total_results INTEGER NOT NULL,
        cached_at INTEGER NOT NULL,
        PRIMARY KEY (category, page)
      )
    ''');

    // Create index for faster queries
    await db
        .execute('CREATE INDEX idx_category_page ON movies(category, page)');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add metadata table in version 2
      await db.execute('''
        CREATE TABLE IF NOT EXISTS movies_metadata (
          category TEXT NOT NULL,
          page INTEGER NOT NULL,
          total_pages INTEGER NOT NULL,
          total_results INTEGER NOT NULL,
          cached_at INTEGER NOT NULL,
          PRIMARY KEY (category, page)
        )
      ''');
    }
  }

  /// Insert or update a movie
  Future<int> insertMovie(Map<String, dynamic> movie) async {
    final db = await database;
    return await db.insert(
      'movies',
      movie,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Insert or update metadata
  Future<int> insertMetadata(Map<String, dynamic> metadata) async {
    final db = await database;
    return await db.insert(
      'movies_metadata',
      metadata,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get metadata for a category and page
  Future<Map<String, dynamic>?> getMetadata(String category, int page) async {
    final db = await database;
    final results = await db.query(
      'movies_metadata',
      where: 'category = ? AND page = ?',
      whereArgs: [category, page],
      limit: 1,
    );
    return results.isEmpty ? null : results.first;
  }

  /// Insert multiple movies
  Future<void> insertMovies(List<Map<String, dynamic>> movies) async {
    final db = await database;
    final batch = db.batch();
    for (final movie in movies) {
      batch.insert('movies', movie,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  /// Get movies by category and page
  Future<List<Map<String, dynamic>>> getMovies(
      String category, int page) async {
    final db = await database;
    return await db.query(
      'movies',
      where: 'category = ? AND page = ?',
      whereArgs: [category, page],
      orderBy: 'cached_at DESC',
    );
  }

  /// Get all movies for a category
  Future<List<Map<String, dynamic>>> getAllMoviesByCategory(
      String category) async {
    final db = await database;
    return await db.query(
      'movies',
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'page ASC, cached_at DESC',
    );
  }

  /// Clear old cache (older than 24 hours)
  Future<int> clearOldCache() async {
    final db = await database;
    final oneDayAgo = DateTime.now()
        .subtract(const Duration(hours: 24))
        .millisecondsSinceEpoch;
    return await db.delete(
      'movies',
      where: 'cached_at < ?',
      whereArgs: [oneDayAgo],
    );
  }

  /// Clear all movies for a category
  Future<int> clearCategory(String category) async {
    final db = await database;
    return await db.delete(
      'movies',
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  /// Clear all data
  Future<int> clearAll() async {
    final db = await database;
    return await db.delete('movies');
  }

  /// Close database
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
