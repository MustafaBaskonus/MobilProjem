mixin  StudentValidationMixin {
  String? validateFirstName(String value){
    if(value.length<2){
      print( "İsim en az iki karakter olmalıdır.");
    }
  }
}