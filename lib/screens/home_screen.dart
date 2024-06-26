import 'package:ai_room/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: MyFloatingActionButton(),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              HeaderWidget(searchController: searchController),
              const Expanded(child: EmptyWidget())
            ],
          ),
        ),
      ),
    );
  }
}

//! Folating Action Button
class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: kPurpleColor,
      elevation: 0,
      onPressed: () {},
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}

//! Header Widget
class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 20, left: 5),
      child: Row(
        children: [
          Expanded(
            child: SearchBarAnimation(
              textEditingController: searchController,
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
          const SizedBox(
            width: 10,
          ),
          const Text(
            'تراکنش ها',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
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
          height: height * 0.3,
        ),
        const Text('!تراکنشی موجود نیست', style: TextStyle(fontSize: 20)),
        const Spacer(),
      ],
    );
  }
}
