class Failure {
  int code; //200 or 400
  String message; //error or success

  Failure(this.code, this.message);
}

class DefaultFailure extends Failure {
  DefaultFailure() : super(-1, 'Unknown Error');
}

class InternetError extends Failure {
  InternetError()
      : super(-5, 'Something went wrong,try turning on internet and try again');
}
