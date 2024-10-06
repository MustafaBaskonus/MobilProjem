import 'package:flutter/material.dart';
import 'models/student.dart';
import 'screens/student_add.dart';
import 'screens/student_edit.dart';

void main() {
  //flutter dan gelen runApp fonksiyonunu kullanılır.meteryal standartlarına uymak için MaterialApp
  //fonksiyonu kullanılır.Bu MaterialApp fonksiyonun bir constructor u var ve home parametresi
  //vasıtası ile  MyApp widget i kullanılabiliyor.biz başka widgetlerde atayabiliriz.
  //MyApp bizim oluşturduğumuz bir widget. StatelessWidget den inherit edildiği için widget olmuştur.
  runApp(MaterialApp(home: MyApp()));
}

//statelessWidget ile inherit alarak Widget oluşturduk.StatelessWidget de widget den inherit almaktadır.
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();// bir fonksiyonun hızlı bir şekilde çağrımı
}

class _MyAppState extends State<MyApp> {
  //var ogrenciler = ["Mustafa", "ahmet", "ömer"];
  String mesaj = "Ögrenci Takip Sistemi";
  Student selectedStudent =Student.withId(0,"", "", 0);
  List<Student> students = [
    Student.withId(1,"Mustafa", "Baskan", 35),
    Student.withId(2,"Yusuf", "Varış", 45),
    Student.withId(3,"Ayse", "Baskan", 65)
  ];


  @override
  //Bu bir fonksiyondur.widget dönderir.
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(mesaj),
          backgroundColor: Colors.yellow,
        ),
        body: buildBody(context)
    );
    throw UnimplementedError();
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
                itemCount: students.length,
                //listviews ın builder ı eleman sayısı kadar altdaki kodu çalıştırmaya yarar
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2018/06/27/07/45/student-3500990_960_720.jpg"),
                      ),
                      title: Text(students[index].firstName! + " " + students[index].lastName!),
                      subtitle: Text("Sınavdan aldığı not: " + students[index].grade.toString() + " [" + students[index].getStatus.toString() + "]"),
                      trailing: buildStatusIcon(students[index].grade),
                      onTap: () {//tıklama
                        setState(() { // seciliOgrenci yi kullanan yerler yeniden çizilsin
                          selectedStudent =students[index];
                        });
                        print(selectedStudent.firstName.toString());
                      });
                })
        ),
        Text("Seçili Öğrenci: " + selectedStudent.firstName.toString()),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(

                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.lightGreen)),
                child: Row(
                  children: [
                    Icon(Icons.plus_one),
                    SizedBox(width: 5.0,),
                    Text("Yeni",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentAdd(students)));//referans tipi olduğu için adresi yollanmış oldu.
                },
              ),
            ),

            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.grey)),
                child: Row(
                  children: [
                    Icon(Icons.update),
                    SizedBox(width: 5.0,),
                    Text("Güncelle", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                  ],
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentEdit( selectedStudent)));//referans tipi olduğu için adresi yollanmış oldu.
                },
              ),
            ),


            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.redAccent)),
                child: Row(
                  children: [
                    Icon(Icons.delete_forever),
                    SizedBox(width: 5.0,),
                    Text("Sil",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onPressed: () {
                  setState((){students.remove(selectedStudent);});//bu satırdaki değişikliği kullanan başka bir yer varsa oralarıda güncelle.
                  var mesaj = "Silindi";
                  mesajGoster(context, mesaj);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildStatusIcon(int? grade) {
    if (grade! >= 50) {
      return Icon(Icons.done);
    } else if (grade >= 40) {
      return Icon(Icons.album);
    } else {
      return Icon(Icons.dangerous);
    }
  }
}

String sinavHesapla(int puan) {
  String mesaj = "";
  if (puan >= 50) {
    mesaj = "Geçti";
  } else if (puan >= 40) {
    mesaj = "büte kaldı";
  } else {
    mesaj = "kaldı";
  }
  return mesaj;
}

void mesajGoster(BuildContext context, String mesaj) {
  var alert = AlertDialog(
    title: Text("İşlem Durumu"),
    content: Text(mesaj),
  );
  showDialog(context: context, builder: (BuildContext context) => alert);
}
