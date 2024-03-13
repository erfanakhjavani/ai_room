import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool ontap = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color.fromARGB(255, 27, 211, 178),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SafeArea(
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Lottie.asset('assets/1.json',
                              height: 250,
                              width: double.infinity,
                              fit: BoxFit.fitHeight),
                          const SizedBox(
                            height: 10,
                          ),
                        AnimatedCrossFade(
                            firstChild: SizedBox(height: 200,
                                child: Image.asset("assets/smile.png")
                            ),
                            secondChild: SizedBox(height: 200,child: Image.asset("assets/Depressed.png")),

                            crossFadeState: ontap ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                            duration: const Duration(milliseconds: 100)
                        ),


                    SizedBox(
                      width: Get.width/2,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            ontap = true;
                          });
                        }, child: const Text(
                          "add Time for connection",
                        style: TextStyle(color: Colors.black),
                      ),

                      ),
                    )
                        ])
                )
            )
        )
    );
  }
}
