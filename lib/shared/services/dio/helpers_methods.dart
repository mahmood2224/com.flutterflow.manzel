void debugPrintPreRequest({url , data,headers}){
  print(
      "url : $url \n data : $data \n headers : $headers "
  );
}

bool isValidResponse(int statusCode , {int responseStatus = 1}) {
  return statusCode >= 200 && statusCode <= 302 && responseStatus ==1;
}

void handleUnAuthorized( { required int statusCode})async{
  if(statusCode >= 400 && statusCode <= 403) {
    // showAlertMessage(context, message: "Please_login_again".tr() , backgroundColor: Colors.red);
    // di.get<StreamingSharedPreferences>().clear();
    // navigateTo(context, LoginNumberScreen() ,removeAll: true);
  }
}
