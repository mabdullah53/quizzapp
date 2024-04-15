import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizz_app/Screen/splash_screen.dart';

class ResultScreen extends StatefulWidget {

   ResultScreen({super.key,required this.totalQuestion,required this.correctAnswer});

    int totalQuestion;
    int correctAnswer;

   @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String resultText = "";
  String resultDescription = "";
 // int totalQuestion = 20;


  @override
  void initState() {
    // TODO: implement initState
    double percentage = (widget.correctAnswer / widget.totalQuestion)*100;
    // String resultText;
    // String resultDescription;

    if(percentage>= 80){
      resultText = "Congratulation!";
      resultDescription = "You did great!";
    }else if(percentage >= 60) {
      resultText = "Well Done";
      resultDescription = "You can do even better!";
    }else{
       resultText = "Keep Practising";
       resultDescription = "you can improve";
    }
    super.initState();
  }



  @override


  Widget build(BuildContext context) {

    // double percentage = (widget.correctAnswer / widget.totalQuestion)*100;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: 0.5,
                  image: NetworkImage('https://images.pexels.com/photos/1633413/pexels-photo-1633413.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                 fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 55,right: 280),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SplashScreen()));
                      },
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.white
                          )
                          //color: Colors.white,
                        ),


                        child: Center(
                          child: Text('<',style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 200,left: 70),
                        child: Text('Your Result',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 45,
                          fontFamily: 'Fountmain',
                         ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Center(
                          child: Text("| ${resultText} |",
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(resultDescription,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("You got ${widget.correctAnswer} out of ${widget.totalQuestion}!",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
