import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "todo app",
      theme: ThemeData(
        primaryColor: Colors.blue[900],
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          
        },
        child:Icon(
            Icons.add,
        ),
      ),
      appBar: AppBar(
        title: Text("todo"),
      ),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
             return Text("Something wrong");
          }
          if (snapshot.connectionState==ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            )
          }
          return Container(
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(12),
           ),
           child: ListView.builder(
             itemCount: snapshot.data!.docs.length,
             itemBuilder: (_, index){
               return GestureDetector(
                 onTap:(){
                   Navigator.push(
                     context, 
                     MaterialPageRoute(
                       builder:(_)=>
                        editnote(docid:snapshot.data!.docs[index]),
                      ),
                    );
                 },
                 child: Column(
                   children: [
                     SizedBox(
                       height: 4,
                     ),
                     Padding(padding: EdgeInsets.only(
                       left: 3,
                       right: 3,
                     ),
                     child: ListTile(
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10),
                         side: BorderSide(
                           color: Colors.black,
                         ),
                       ),
                       title: Text(
                         snapshot.data!.docChange[index].doc['title'],
                         style: TextStyle(
                           fontSize: 20,
                         ),
                       ),
                        subtitle: Text(
                         snapshot.data!.docChange[index].doc['title'],
                         style: TextStyle(
                           fontSize: 20,
                         ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                     ),
                   ],
                 ),
               ),
             },
            ),
          );
        },
      ),
    ),
  }
}