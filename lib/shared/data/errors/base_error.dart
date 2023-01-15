abstract class BaseError{
  BaseError(this.errorMessage ,{this.error});
  String errorMessage ;
  dynamic error ;
}

class MainResponseError extends BaseError{
  MainResponseError(super.errorMessage,{super.error});
}