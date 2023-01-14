//TODO apply translation
class GeneralValidator{

  static String? requiredValidator(String? txt){
    if(txt?.isEmpty??true)
      return "this field is required";

    return null;
  }
}