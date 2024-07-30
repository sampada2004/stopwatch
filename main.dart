	import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyCIxLyxzcBAEfs4XAMjYnzIvq9RDM4DCDs",
  authDomain: "stopwatch-114cb.firebaseapp.com",
  projectId: "stopwatch-114cb",
  storageBucket: "stopwatch-114cb.appspot.com",
  messagingSenderId: "731112225225",
  appId: "1:731112225225:web:aee8479bbdbdc28b8c9018"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeApp(),
    );
  }
}
class HomeApp extends StatefulWidget{
  const HomeApp({Key? key}) : super(key: key);
  
  @override
  _HomeAppState createState() => _HomeAppState();
}
class _HomeAppState extends State<HomeApp> {
  int seconds=0,minutes=0,hours=0;
  String digitseconds="00",digitminutes="00",digithours="00";
  Timer? timer;
  bool started=false;
  


  void stop(){
    timer!.cancel();
    setState(() {
      started=false;
    });
  }

  void reset(){
  timer!.cancel();
  setState(() {
    seconds=0;
    minutes=0;
    hours=0;
    digitseconds="00";
    digitminutes="00";
    digithours="00";
    started=false;
  });
  }
  void start(){
    started=true;
    timer=Timer.periodic(Duration(seconds: 1)
      , (timer) {int localSeconds=seconds+1;
      int locaMinutes=minutes;
      int localHours=hours;
      if(localSeconds>59){
        if(locaMinutes>59){
          localHours++;
          locaMinutes=0;
        }else{
          locaMinutes++;
          localSeconds=0;
        }
      }
      setState(() {
        seconds=localSeconds;
        minutes=locaMinutes;
        hours=localHours;
        digitseconds=(seconds>10)?"$seconds":"0$seconds";
        digithours=(hours>10)?"$hours":"0$hours";
        digitminutes=(minutes>10)?"$minutes":"0$minutes";
      }); });
    
  }
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0) ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text("StopWatch App",style: TextStyle(color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,)),),
              SizedBox(height: 20.0
              ,),
              

              Container(
                height: 100.0,
                decoration: BoxDecoration(color: Colors.grey,
                borderRadius: BorderRadius.circular(8.0,),),
                child: Text("$digithours:$digitminutes:$digitseconds",
              style: TextStyle(color: Colors.black,fontSize: 70.0,
              fontWeight: FontWeight.w600,),),),
              
           SizedBox(height: 20.0),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
              Expanded(child: RawMaterialButton(onPressed: () {
                (!started)?start():stop();
              },
              shape: StadiumBorder(side: BorderSide(color: Colors.white),),
              child: Text((!started)? "start": "pause",
              style: TextStyle(color: Colors.white))),),
            SizedBox(width: 8.0,),
            IconButton(
              color: Colors.white,
              onPressed: () {},icon: Icon(Icons.lock_clock),
             
           ),
           Expanded(child: RawMaterialButton(onPressed: () {
            reset();
           },
           fillColor: Colors.white,
              shape: StadiumBorder(side: BorderSide(color: Colors.white),),
              child: Text("Reset",style: TextStyle(color: Colors.black))),),],
           ),
            ],),),),
    );

    
  }
}
