class Failure implements Exception {
  final String message;
  final int? code;

  Failure(this.message, {this.code});

  @override
  String toString() => 'Failure: $message';
}
