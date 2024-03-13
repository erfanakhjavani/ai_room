import 'dart:async';

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
  bool ontap2 = false;


  Timer? _timer;
  int _start = 0;

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_start < 1) {
          timer.cancel();
        } else {
          _start--;
          if(_start == 0){
            ontap = false;
          }
        }
      });
    });
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    seconds %= 3600;
    int minutes = seconds ~/ 60;
    seconds %= 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }


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

                          Text(
                            formatTime(_start),
                            style:
                              const TextStyle(color: Colors.white,fontSize: 40)
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(

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
                            _start += 5;
                          });
                          startTimer();
                        }, child: const Text(
                          "add Time for connection",
                        style: TextStyle(color: Colors.black),
                      ),

                      ),
                    ),
                    if(ontap)
                    SizedBox(
                      height: 70,
                      child: InputChip(
                              side: const BorderSide(color: Colors.transparent),
                             padding: const EdgeInsets.fromLTRB(40,15,40,15),
                             label: Text(ontap2 == false ? 'Connect' : 'Disconnect'),
                             labelStyle: const TextStyle(color: Colors.white),

                             backgroundColor: ontap ? Colors.green : Colors.grey,

                             onSelected: _start > 0 ? (bool value) {
                               setState(() {
                                 if(ontap == true) {
                                   ontap2 = value;
                                 } else {
                                   null;
                                 }
                               });
                             }:null,
                             selected: ontap2,
                             showCheckmark: false,
                             selectedColor: ontap2 == true ? Colors.red : Colors.green,
                           ),
                    ),

                        ])
                )
            )
        )
    );
  }
}
