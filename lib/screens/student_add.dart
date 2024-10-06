import 'package:flutter/material.dart';

import '../models/student.dart';







class StudentAdd extends StatefulWidget{
  //constructor
  late List<Student> students;
  StudentAdd(List<Student> students){ this.students =students;}
  @override
  State<StatefulWidget> createState() {
    return _StudentAddState(students);//alt çizgi bu fonksiyonun bu sınıfa özel olduğunu göstermek için kullanır
  }
}
//StudentValidationMixin dan inherit olmasın ama onun fonksiyonlarınıda kullansın
class _StudentAddState extends State /*with StudentValidationMixin*/{
  late List<Student> students;
  var student = Student.withoutInfo();//ğrenci contructor boş olan.
  var formKey = GlobalKey<FormState>();
  //constructor
  _StudentAddState(List<Student> students){ this.students =students;}

  @override
  //widget ağıcını çizdiğimiz yer
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Yeni Öğrenci Ekle"),
        ),
        body: Container(
          margin: EdgeInsets.all(20.0),//tüm köşelerden boşluk bırak
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  buildFirstNameField(),
                  buildLastNameField(),
                  buildGradeField(),
                  buildSubmitButton(),
                ],
              )
          ),
        )
    );
  }

  Widget buildFirstNameField() {
    //formlar için text alanı ayarlayan widget TextFormFild.
    return TextFormField(//decoration mobil cihazlara yönelikçalışmalar yapar.
      decoration: InputDecoration(labelText: "Öğrenci adı", hintText: "mustafa"),
      //validator: valdateFirstName,//alana girilen verinin formatı için kuralllar.
      onSaved: (String? value){student.firstName = value;},
    );
  }
  Widget buildLastNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci soyadı", hintText: "Baskonus"),
      //validator: valdateFirstName,//alana girilen verinin formatı için kuralllar.
      onSaved: (String? value){student.lastName = value;},
    );
  }
  Widget buildGradeField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Aldığı Not", hintText: "65"),
      //validator: valdateFirstName,//alana girilen verinin formatı için kuralllar.
      onSaved: (String? value){student.grade = int.parse(value!);},
    );
  }

  buildSubmitButton() {
    return ElevatedButton(
      child: Text("Kaydet"),
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen)
      ),
      onPressed: () {
        //burdan formun altındaki fonksiyonların hepsini tetiklememiz gerek. Bu yüzden forma yünik  bir değer atamsı yapıyoruz.
        formKey.currentState?.save();
        students.add(student);
        savedStudent();
        Navigator.pop(context);
        /*if(formKey.currentState.validate()){
          formKey.currentState.save();//doğrulama yapamadığım için kapattım.
        }*/
      },
    );
  }

  void savedStudent() {
    print(student.firstName);
    print(student.lastName);
    print(student.grade);
  }

}