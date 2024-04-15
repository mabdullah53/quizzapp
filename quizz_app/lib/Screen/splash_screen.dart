import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizz_app/Screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://images.pexels.com/photos/10286432/pexels-photo-10286432.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                    fit: BoxFit.cover,
                  ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 220,top: 380),
                    child: Text('Wellcome to the',style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text('Quizz App',style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Fountmain',
                          fontSize: 43,
                          fontWeight: FontWeight.w600,
                        ),),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text("Do you feel confident? Here you'll face our most\n difficult questions!",style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),),
                      )
                    ],
                  ),
                  SizedBox(height: 120,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                        },
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Center(child: Text('Countinue',style: TextStyle(
                            color: Colors.black,
                            fontSize: 19
                          ),)),

                        ),
                      )
                    ],
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
