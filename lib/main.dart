import "dart:async";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
void main(){
  runApp(to_do());
}
List<String> hello=[];
class to_do extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "To-Do List",
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      debugShowCheckedModeBanner: false,
      home: splash(),
    );
  }
}
class splash extends StatefulWidget{
  @override
  State<splash> createState()=>_splash();
}
class _splash extends State<splash>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>main_to_do()));
    });
    call();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.yellow.shade500,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                  width: 100,
                  child: Image.asset("assets/images/to-do_list.png")),
              Text("TO-DO",style: TextStyle(fontSize: 40,fontFamily: "Strong",fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    );
  }
  void call() async{
    var pref=await SharedPreferences.getInstance();
    hello=pref.getStringList("abir")??[];
  }
}
class main_to_do extends StatefulWidget{
  @override
  State<main_to_do> createState() => _main_to_doState();
}

class _main_to_doState extends State<main_to_do> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print(obj2.hall);
    print(hello);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text("TO DO LIST")
      ),
      body: Container(
        color: Colors.yellow.shade500,
        child: hello.isEmpty ? Center(
            child: Text("List Is empty")):
            ListView(
              children: hello.map((e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 100,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width-15,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(child: Text(e)),
                        ),
                        InkWell(
                          child: Container(
                            height: 100,
                            width: 200,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: const Icon(Icons.delete),
                          ),
                          onTap: () async{
                            hello.remove(e);
                            var pref=await SharedPreferences.getInstance();
                            pref.setStringList("abir", hello);
                            setState(() {

                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )).toList(),
            )
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>task_page()));
        },
      ),
    );
}
}
class task_page extends StatefulWidget{
  @override
  State<task_page> createState() => _task_pageState();
}

class _task_pageState extends State<task_page> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var taskval=TextEditingController();
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: Center(
          child: Container(
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("Add Task"),
                  TextField(
                    controller: taskval,
                    decoration: InputDecoration(
                        label: Text("Task"),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(21),
                            borderSide: BorderSide(
                                color: Colors.yellow,
                                width: 2
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                width: 2
                            )
                        )
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: () async{
                        print(taskval.text.toString());
                        hello.add(taskval.text.toString());
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>main_to_do()));
                        var pref=await SharedPreferences.getInstance();
                        pref.setStringList("abir", hello);
                        //hello=obj.list;
                        print(hello);
                        setState(() {

                        });
                      }, child: Text("Add Task")),
                      ElevatedButton(onPressed: (){
                        //list.add(taskval.text.toString());
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>main_to_do()));
                      }, child: Text("Back")),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}