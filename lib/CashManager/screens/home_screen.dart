
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

import '../../constants.dart';
import '../../main.dart';
import '../models/money.dart';
import 'new_transactions_screen.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

 static List<Money> moneys = [];
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
     MyApp.getData();
    // TODO: implement initState
    super.initState();
  }

  Box<Money> hiveBox = Hive.box<Money>('moneyBox');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton:  fabWidget(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            headerWidget(),
            //    const Expanded(child: EmptyWidget()),
            Expanded(
              child: HomeScreen.moneys.isEmpty ? const EmptyWidget() :
              ListView.builder(
                  itemCount: HomeScreen.moneys.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      //! Edit
                      onTap: (){

                        //
                        NewTransactionsScreen
                            .date = HomeScreen.moneys[index].date;
                        //* Edit
                        NewTransactionsScreen.descriptionController
                            .text = HomeScreen.moneys[index].title;
                        //
                        NewTransactionsScreen.priceController
                            .text = HomeScreen.moneys[index].price;
                        //
                        NewTransactionsScreen
                            .isEditing = true;
                        //
                        NewTransactionsScreen
                            .id = HomeScreen.moneys[index].id;

                        NewTransactionsScreen.
                        groupId = HomeScreen.moneys[index].isReceived ? 2 : 1;

                        Navigator.push(context, MaterialPageRoute(
                            builder: (_)=> const NewTransactionsScreen())).then((value){
                              MyApp.getData();
                              setState(() {});
                        });
                      },
                      //! Delete
                        onLongPress: (){
                          showDialog(context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  'آیا از حذف این آیتم مطمئن هستید؟',
                                  style: textSmall(),
                                  textDirection: TextDirection.rtl,
                                ),
                                actionsAlignment: MainAxisAlignment.spaceBetween,
                                actions: [
                                  TextButton(onPressed: (){
                                  }, child: const Text('خیر')),
                                  TextButton(
                                      onPressed: (){
                                    hiveBox.deleteAt(index);
                                    MyApp.getData();
                                    setState(() {});
                                    Navigator.pop(context);
                                  }, child: const Text('بله')),

                                ],
                              ));
                        },
                        child: MyListTileWidget(index: index,));
                  }),
            ),

          ],
        ),
      ),
    );
  }

  //! Floating Action Button
  Widget fabWidget(){
    return FloatingActionButton(
      backgroundColor: kPurpleColor,
      elevation: 0,
      onPressed: () {
        NewTransactionsScreen.date = "انتخاب تاریخ";
        NewTransactionsScreen.descriptionController.text = '';
        NewTransactionsScreen.priceController.text = '';
        NewTransactionsScreen.groupId = 0;
        NewTransactionsScreen.isEditing = false;
        Navigator.push(
            (context),
            MaterialPageRoute(
                builder: (context) => const NewTransactionsScreen())).then((value) {
                  MyApp.getData();
                  setState(() {

                  });
        });
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  //! header Widget
   Widget headerWidget(){
    return Padding(
      padding: const EdgeInsets.only( top: 20, left: 5),
      child: Row(
        children: [
          Expanded(
            child: SearchBarAnimation(
              textEditingController: searchController,
              onFieldSubmitted: (String text){
                List<Money> result = hiveBox.values.where((value) => value.title.contains(text) || value.date.contains(text)).toList();
                HomeScreen.moneys.clear();
                setState(() {
                  for (var value in result) {
                    HomeScreen.moneys.add(value);
                  }
                });
              },
              hintText: '...جستجو کنید',
              isOriginalAnimation: false,
              enableKeyboardFocus: true,
              trailingWidget: const Icon(
                Icons.search,
                size: 20,
                color: Colors.black,
              ),
              secondaryButtonWidget: const Icon(
                Icons.close,
                size: 20,
                color: Colors.black,
              ),
              buttonWidget: const Icon(
                Icons.search,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),

          const Text(
            'تراکنش ها',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_forward))
        ],
      ),
    );
  }

}


//! My List Tile widget
class MyListTileWidget extends StatelessWidget {

  final int index;
  const MyListTileWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: HomeScreen.moneys[index].isReceived ? kGreenColor : kRedColor,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child:  Center(
              child: Icon(
                HomeScreen.moneys[index].isReceived ? Icons.add : Icons.remove,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
            ),
            child: Text(
              HomeScreen.moneys[index].title,
              style: textMedium(),
            ),
          ),
          const Spacer(),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    'تومان ',
                    style: textLarge(color: HomeScreen.moneys[index].isReceived ? kGreenColor : kRedColor),
                  ),
                  Text(
                    HomeScreen.moneys[index].price,
                    style: textLarge(color: HomeScreen.moneys[index].isReceived ? kGreenColor : kRedColor),
                  ),
                ],
              ),
               Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(HomeScreen.moneys[index].date),
              )
            ],
          )
        ],
      ),
    );
  }
}





//! EmptyWidget
class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Column(
      children: [
        const Spacer(),
        SvgPicture.asset(
          colorFilter: const ColorFilter.mode(kPurpleColor, BlendMode.lighten),
          'assets/images/1.svg',
          width: width * 0.65,
          height: height * 0.25,
        ),
        const Text('!تراکنشی موجود نیست', style: TextStyle(fontSize: 20,color: kPurpleColor)),
        const Spacer(),
      ],
    );
  }
}
