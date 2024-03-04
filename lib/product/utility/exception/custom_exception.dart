class FirebaseCustuomException implements Exception {
  FirebaseCustuomException(this.description);

  final String description;
  @override
  String toString() {
    return '$this $description';
  }
}

class VersionCustuomException implements Exception {
  VersionCustuomException(this.description);

  final String description;
  @override
  String toString() {
    return '$this $description';
  }
}
