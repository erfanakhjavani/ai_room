import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../constants.dart';
import '../../main.dart';
import '../models/money.dart';

class NewTransactionsScreen extends StatefulWidget {
   const NewTransactionsScreen({super.key});

 static  int groupId = 0;
 static TextEditingController descriptionController =  TextEditingController();
 static TextEditingController priceController =  TextEditingController();
 static bool isEditing = false;
 static int id = 0;
 static String date = "انتخاب تاریخ";


  @override
  State<NewTransactionsScreen> createState() => _NewTransactionsScreenState();
}

class _NewTransactionsScreenState extends State<NewTransactionsScreen> {
  Box<Money> hiveBox = Hive.box<Money>('moneyBox');

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              NewTransactionsScreen.isEditing ? "ویرایش تراکنش" : "تراکنش جدید"  ,
              style: textBig(),
            ),
          ),
          backgroundColor: Colors.white,
          body: Container(
            margin: const EdgeInsets.all(12.0),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                 MyTextFieldWidget(
                  controller: NewTransactionsScreen.descriptionController,
                  hintText: "توضیحات",
                ),
                const SizedBox(height: 8),
                 MyTextFieldWidget(
                  controller: NewTransactionsScreen.priceController,
                  hintText: "مبلغ",
                  type: TextInputType.number,
                ),
                const SizedBox(height: 8),
                 const TypeAndDate(),
                const SizedBox(height: 8),
                MyButton(
                  onPressed: (){
                    if(NewTransactionsScreen.descriptionController.text.isEmpty ||
                      NewTransactionsScreen.priceController.text.isEmpty
                    ){
                      return checkField(context, "لطفا فیلد ها را تکمیل کنید!");
                    }
                    else if(NewTransactionsScreen.date == 'انتخاب تاریخ'){
                      return checkField(context, "لطفا تاریخ را انتخاب کنید!");
                    }
                    else if(NewTransactionsScreen.groupId == 0){
                      return checkField(context, "لطفا یک گزینه را انتخاب کنید!");
                    }
                    Money item = Money(
                            id: Random().nextInt(99999999),
                            title: NewTransactionsScreen.descriptionController.text,
                            price: NewTransactionsScreen.priceController.text,
                            date: NewTransactionsScreen.date,
                            isReceived: NewTransactionsScreen.groupId == 1 ? false : true
                        );
                    if(NewTransactionsScreen.isEditing){
                      int index = 0;
                      MyApp.getData();
                      for(int i = 0; i < hiveBox.values.length; i++){
                        if(hiveBox.values.elementAt(i).id ==
                          NewTransactionsScreen.id
                        ){
                          index = i;
                        }
                      }
                      hiveBox.putAt(index, item);
                      // HomeScreen.moneys[NewTransactionsScreen.index] = item;
                    }else{
                      // HomeScreen.moneys.add(item);
                      hiveBox.add(item);
                    }
                   Navigator.pop(context);
                  },
                  text: NewTransactionsScreen.isEditing ? "ویرایش کردن" : "اضافه کردن",
                )
              ],
            ),
          )),
    );
  }
}

//! My button
class MyButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style:
              TextButton.styleFrom(backgroundColor: kPurpleColor, elevation: 0),
          onPressed: onPressed,
          child: Text(
            text,
            style: textMedium(color: Colors.white),
          )),
    );
  }
}

//! Type and date widget
class TypeAndDate extends StatefulWidget {
  const TypeAndDate({super.key});

  @override
  State<TypeAndDate> createState() => _TypeAndDateState();
}

class _TypeAndDateState extends State<TypeAndDate> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        SizedBox(
          height: 30,
          child: OutlinedButton(
              onPressed: () async{
                var pickerDate = await showPersianDatePicker(
                    context: context,
                    initialDate: Jalali.now(),
                    firstDate: Jalali(1403),
                    lastDate: Jalali(1500),

                );
                setState(() {
                  String year = pickerDate!.year.toString();
                  String month = pickerDate.month.toString().length == 1 ? '0${pickerDate.month.toString()}' :
                  pickerDate.month.toString()
                  ;
                  String day = pickerDate.day.toString().length == 1 ? '0${pickerDate.day.toString()}' :
                  pickerDate.day.toString()
                  ;
                  NewTransactionsScreen.date = '$year/$month/$day';
                });
              }, child: Text(
             NewTransactionsScreen.date
              ,
              style: textSmall())),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: MyRadioButton(
            value: 1,
            groupValue: NewTransactionsScreen.groupId,
            title: 'پرداختی',
            onChanged: (value) {
              setState(() {
                NewTransactionsScreen.groupId = value!;
              });
            },
          ),
        ),
        Expanded(
          child: MyRadioButton(
            value: 2,
            groupValue:  NewTransactionsScreen.groupId,
            title: 'دریافتی',
            onChanged: (value) {
              setState(() {
                NewTransactionsScreen.groupId = value!;
              });
            },
          ),
        ),
      ],
    );
  }
}

//! Radio button
class MyRadioButton extends StatelessWidget {
  final int value;
  final int groupValue;
  final Function(int?) onChanged;
  final String title;

  const MyRadioButton(
      {super.key,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(title),
        Expanded(
          child: Radio(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
        ),

      ],
    );
  }
}

//! Text Field Widget
class MyTextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextInputType type;
  final TextEditingController controller;

  const MyTextFieldWidget(
      {super.key, required this.hintText, this.type = TextInputType.text, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          hintText: hintText),
    );
  }
}


Future checkField(BuildContext context, String text){
  return showDialog(context: context,
      builder: (context) => AlertDialog(
        title: Text(
          text,
          style: textSmall(),
          textDirection: TextDirection.rtl,
        ),
        content: TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text('باشه'),
        ),
      ));
}