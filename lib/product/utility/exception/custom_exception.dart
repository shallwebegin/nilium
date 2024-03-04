class FirebaseCustuomException implements Exception {
  FirebaseCustuomException(this.description);

  final String description;
  @override
  String toString() {
    return '$this $description';
  }
}
