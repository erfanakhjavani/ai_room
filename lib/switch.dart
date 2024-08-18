import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'CashManager/screens/main_screen.dart';
import 'constants.dart';
import 'hangman/playground.dart';

class SwitchScreen extends StatelessWidget {
  const SwitchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("پروژه دانشگاه آزاد"),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){
              showDialog(context: context,
                  builder: (context) => AlertDialog(

                    title: Center(
                      child: Text(
                        'پروژه دانشگاه آزاد',
                        style: textLarge(),
                      ),
                    ),
                    content:  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('استاد مربوطه : مهندس صارمی'),
                        const SizedBox(height: 10,),
                        const Text('طراح : عرفان اخجوانی'),
                        const SizedBox(height: 10,),
                        const Text('تلگرام : ErfanRaviar@',textDirection: TextDirection.rtl,),
                        const SizedBox(height: 20,),
                        SizedBox(
                            height: 60,
                            width: 60,
                            child: SvgPicture.asset('assets/images/raviar.svg')),
                      ],
                    ),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          }, child:  Text('باشه',style: textMedium().copyWith(color: Colors.grey),)),

                    ],
                  ));
            }, icon: const Icon(Icons.info))
          ],
        ),
        body:    Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push((context), MaterialPageRoute(builder: (context) => const MainScreen()));
                  },
                  child: const Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/moneyManagement.jpg'),
                      ),
                      SizedBox(height: 10,),
                      Text('اپلیکیشن مدیریت مالی')
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push((context), MaterialPageRoute(builder: (context) =>  Playground()));
                  },
                  child: const Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/hangman.jpg'),
                      ),
                      SizedBox(height: 10,),
                      Text('هنگ من')
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
