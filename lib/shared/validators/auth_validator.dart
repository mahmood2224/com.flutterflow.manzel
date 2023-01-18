//TODO apply translation
class AuthValidator{

  static String? validateNumber(String? number){
    if(number?.isEmpty??true)
      return "Please add your number";

    if((number?.length??0) < 8)
      return "Please enter a valid number more than 8 numbers";

    if(!number!.startsWith("05"))
      return "Please enter a valid number begin with 05";

    return null ;
  }

  static String? validateEmail(String? email){
    if(email?.isEmpty??true)
      return "Please add your email";

    bool validEmail = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email!);
    if(!validEmail)
      return "Please enter a valid email less than 8 emails";


    return null ;
  }
}