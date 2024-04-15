import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizz_app/Api_services.dart';
import 'package:quizz_app/Screen/result_screen.dart';
import 'package:quizz_app/Screen/splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 // int totalQuestion [];

  int seconds = 60;
  Timer? timer;
  var currentQuestionIndex =0;
  late Future quiz;

  var isLoaded = false;
  var optionsList = [];
  int totalQuestion = 20;
  int correctAnswer = 0;



  var optionsColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quiz = getQuiz();
    startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer!.cancel();
    super.dispose();
  }



  startTimer(){
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(seconds>0){
          seconds--;
        }else{
          timer.cancel();
        }
      });
    });

  }

  resetColors(){
    optionsColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
         body: Column(
           children: [
             Expanded(
               child: Container(
                 height: double.infinity,
                 width: double.infinity,
                 decoration: const BoxDecoration(
                   image: DecorationImage(
                     opacity: 0.4,
                    // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.srcIn),
                     image: NetworkImage('https://images.pexels.com/photos/2224401/pexels-photo-2224401.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                     fit: BoxFit.cover,

                   )
                 ),
                 child: FutureBuilder(
                   future: quiz,
                   builder: (BuildContext context,AsyncSnapshot snapshot){
                     if(snapshot.hasData){
                       var data = snapshot.data["results"];
                       if(isLoaded == false){
                        optionsList = data[currentQuestionIndex]["incorrect_answers"];
                        optionsList.add(data[currentQuestionIndex]["correct_answer"]);
                        optionsList.shuffle();
                        isLoaded = true;
                       }

                       return SingleChildScrollView(
                         child: Column(
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(top: 50,right: 300),
                               child: GestureDetector(
                                 onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=> SplashScreen()));
                                 },
                                 child: Container(
                                   height: 40,
                                   width: 40,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(25),
                                     color: Colors.white,
                                   ),
                                   child: Center(child: Text('<',style: TextStyle(
                                     fontSize: 24,
                                     color: Colors.purple.shade900,
                                   ),)),
                                 ),
                               ),
                             ),
                             Row(
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.only(left: 160),
                                   child: Stack(
                                     alignment: Alignment.center,
                                     children: [
                                       Text("$seconds",style: TextStyle(
                                         color: Colors.white,
                                         fontSize: 22,
                                       ),),
                                       SizedBox(
                                         width: 60,
                                         height: 60,
                                         child: CircularProgressIndicator(
                                           value: seconds/60,
                                           valueColor: AlwaysStoppedAnimation(Colors.white),
                                         ),
                                       )
                                     ],
                                   ),
                                 ),
                               ],
                             ),
                             Row(
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.only(top: 160,left: 10),
                                   child: Text("Question ${currentQuestionIndex +1} of ${data.length}",style: TextStyle(
                                     color: Colors.white,
                                     fontSize: 18,
                                     fontWeight: FontWeight.w600,
                                   ),),
                                 ),
                               ],
                             ),
                             SizedBox(height: 20,),
                             Row(
                               children: [
                                 Expanded(
                                   child: Padding(
                                     padding: const EdgeInsets.only(left: 15,right: 15),
                                     child: Text(data[currentQuestionIndex]["question"],
                                       textAlign: TextAlign.left,
                                       style: TextStyle(
                                       color: Colors.white,
                                       fontSize: 20,
                                     ),),
                                   ),
                                 ),
                               ],
                             ),
                             SizedBox(height: 35,),
                             //coloum k andr list view ko use krny k liye shrikwrap true kry
                             ListView.builder(
                                 shrinkWrap: true,
                                 itemCount: optionsList.length,
                                 itemBuilder: (BuildContext context, int index) {

                                   var answer = data[currentQuestionIndex]["correct_answer"];
                                   return Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: GestureDetector(
                                       onTap: (){
                                          setState(() {
                                            if(answer.toString() == optionsList[index].toString()){
                                              optionsColor[index] = Colors.green;
                                              correctAnswer = correctAnswer+1;
                                            }else{
                                              optionsColor[index] = Colors.red.shade900;
                                            }

                                            if(currentQuestionIndex < data.length-1){

                                              Future.delayed(Duration(seconds: 1),(){
                                                isLoaded = false;
                                                currentQuestionIndex++;
                                                  resetColors();
                                                  timer!.cancel();
                                                  seconds = 60;
                                                  startTimer();
                                              });
                                            }else{
                                              timer!.cancel();
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ResultScreen(totalQuestion: totalQuestion, correctAnswer: correctAnswer)));

                                            }


                                          });
                                       },
                                       child: Container(
                                         // margin: EdgeInsets.only(bottom: 5),
                                         height: 50,
                                         width: 280,
                                         decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(8),
                                           color: optionsColor[index]
                                         ),

                                         child: Center(child: Text(optionsList[index].toString(),
                                           style: TextStyle(
                                             color: Colors.black,
                                             fontSize: 19
                                         ),)),

                                       ),
                                     ),
                                   );
                                 }

                             ),
                           ],
                         ),
                       );
                     }
                     else{
                       return Center(child: CircularProgressIndicator(
                         valueColor: AlwaysStoppedAnimation(Colors.white),
                       ));
                     }
                   },
                 )
               ),
             )
           ],
         ),
    );
  }
}
