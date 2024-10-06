import 'package:flutter/material.dart';
import '../models/student.dart';



class StudentEdit extends StatefulWidget{
  late Student selectedStudent;
  StudentEdit(Student selectedStudent){ this.selectedStudent =selectedStudent;}
  @override
  State<StatefulWidget> createState() {
    return _StudentAddState(selectedStudent);
  }
}


class _StudentAddState extends State{
  late Student selectedStudent;

  var formKey = GlobalKey<FormState>();
  //constructor
  _StudentAddState( Student selectedStudent){ this.selectedStudent =selectedStudent;}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Yeni Öğrenci Ekle"),
        ),
        body: Container(
          margin: EdgeInsets.all(20.0),
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
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci adı", hintText: "mustafa"),
      onSaved: (String? value){selectedStudent.firstName = value;},
    );
  }
  Widget buildLastNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci soyadı", hintText: "Baskonus"),
      onSaved: (String? value){selectedStudent.lastName = value;},
    );
  }
  Widget buildGradeField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Aldığı Not", hintText: "65"),

      onSaved: (String? value){selectedStudent.grade = int.parse(value!);},
    );
  }


  buildSubmitButton() {
    return ElevatedButton(
      child: Text("Kaydet"),
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen)
      ),
      onPressed: () {
        formKey.currentState?.save();
        savedStudent();
        Navigator.pop(context);
      },
    );
  }


  void savedStudent() {
    print(selectedStudent.firstName);
    print(selectedStudent.lastName);
    print(selectedStudent.grade);
  }

}