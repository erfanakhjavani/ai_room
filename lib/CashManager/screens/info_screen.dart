
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../utils/calculate.dart';
import '../widgets/chart_widgets.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
          body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0, top: 15.0, left: 5.0),
              child: Text(
                "مدیریت تراکنش ها به تومان",
                style: textLarge(),
              ),
            ),
             MoneyInfoWidget(
                firstText: " : دریافتی امروز",
                firstPrice: Calculate.dToDay().toString(),
                secondText: " : پرداختی امروز",
                secondPrice: Calculate.pToDay().toString()
             ),
             MoneyInfoWidget(
                firstText: " : دریافتی این ماه",
                firstPrice: Calculate.dToMonth().toString(),
                secondText: " : پرداختی این ماه",
                secondPrice: Calculate.pToMonth().toString()),
             MoneyInfoWidget(
                firstText: " : دریافتی امسال",
                firstPrice: Calculate.dToYear().toString(),
                secondText: " : پرداختی امسال",
                secondPrice: Calculate.pToYear().toString()),
            BarChartWidget()
          ],
        ),
      )),
    );
  }
}
 //! Money Info Widget
class MoneyInfoWidget extends StatelessWidget {
  final String firstText;
  final String secondText;
  final String firstPrice;
  final String secondPrice;


  const MoneyInfoWidget({
      required this.firstText, required this.secondText, required this.firstPrice, required this.secondPrice, super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(right: 15.0, top: 20.0, left: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              child: Text(secondPrice,
                textAlign: TextAlign.right,
              )
          ),
          Text(
            secondText,
            textAlign: TextAlign.right,
          ),
          Expanded(
              child: Text(
            "$firstPrice",
            textAlign: TextAlign.right,
          )),
          Text(firstText),
        ],
      ),
    );
  }
}
