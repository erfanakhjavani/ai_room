import 'package:ai_room/switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'CashManager/models/money.dart';
import 'CashManager/screens/home_screen.dart';
import 'hangman/playground_provider.dart';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();
  Hive.registerAdapter(MoneyAdapter());
  await Hive.openBox<Money>('moneyBox');
   runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PlaygorundController()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static void getData() {
  HomeScreen.moneys.clear();
  Box<Money> hiveBox = Hive.box<Money>('moneyBox');
  for (var value in hiveBox.values){
    HomeScreen.moneys.add(value);
  }
}
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return  MaterialApp(
      theme: ThemeData(fontFamily: 'Irs',),
      debugShowCheckedModeBanner: false,
      title: 'IAU Project',
      home: const SwitchScreen(),
    );
  }
}
