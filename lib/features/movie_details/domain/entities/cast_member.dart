/// Represents a cast member in a movie.
class CastMember {
  final int id;
  final String name;
  final String character;
  final String? profilePath;

  const CastMember({
    required this.id,
    required this.name,
    required this.character,
    this.profilePath,
  });
}
