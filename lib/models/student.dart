class Student{
  int? id;
  String? firstName;
  String? lastName;
  int? grade;
  String? _status;
//ekle
  Student(String? firstName,String? lastName,int? grade) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.grade = grade;
    this._status = "";
  }
  //güncelle
  Student.withId(int id,String? firstName,String? lastName,int? grade){
    this.id=id;
    this.firstName=firstName;
    this.lastName= lastName;
    this.grade = grade;
    this._status="";
  }
  Student.withoutInfo(){}//atama yapmadan öğrenci oluşturma.
  String get getFirstName{
    return "OGR - "+this.getFirstName;
  }
  void set setFirstName(String value){
    this.firstName=value;
  }

  //read only bir alan oluşturduk
  String get getStatus{
    String message = "";
    if (this.grade! >= 50) {
      message = "Geçti";
    } else if (this.grade! >= 40) {
      message = "büte kaldı";
    } else {
      message = "kaldı";
    }
    return message;
  }
}