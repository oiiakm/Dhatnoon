abstract class Failure {
  String get errorMessage;
}

class ValidationFailure implements Failure {
  @override
  final String errorMessage;

  ValidationFailure(this.errorMessage);

  @override
  String toString() {
    return errorMessage;
  }
}
