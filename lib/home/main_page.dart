// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/home/chat_page.dart';
import 'package:shamo/home/home_page.dart';
import 'package:shamo/home/profile_page.dart';
import 'package:shamo/home/wishlist_page.dart';
import 'package:shamo/providers/page_provider.dart';
import 'package:shamo/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    @override
    Widget cartButton(BuildContext context) {
      return FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        child: Image.asset(
          'assets/icon_cart.png',
          width: 20,
        ),
      );
    }

    Widget customeBottomNav() {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25),
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 12,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
              currentIndex: pageProvider.currentIndex,
              onTap: (value) {
                pageProvider.currentIndex = value;
              },
              backgroundColor: backgroundColor4,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                        bottom: 10,
                      ),
                      child: Image.asset(
                        'assets/icon_home.png',
                        width: 21,
                        color: pageProvider.currentIndex == 0
                            ? primaryColor
                            : const Color(0xff808191),
                      ),
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                        bottom: 10,
                      ),
                      child: Image.asset(
                        'assets/icon_chat.png',
                        width: 20,
                        color: pageProvider.currentIndex == 1
                            ? primaryColor
                            : const Color(0xff808191),
                      ),
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                        bottom: 10,
                      ),
                      child: Image.asset(
                        'assets/icon_wishlist.png',
                        width: 20,
                        color: pageProvider.currentIndex == 2
                            ? primaryColor
                            : const Color(0xff808191),
                      ),
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                        bottom: 10,
                      ),
                      child: Image.asset(
                        'assets/icon_profile.png',
                        width: 18,
                        color: pageProvider.currentIndex == 3
                            ? primaryColor
                            : const Color(0xff808191),
                      ),
                    ),
                    label: ''),
              ]),
        ),
      );
    }

    Widget body() {
      switch (pageProvider.currentIndex) {
        case 0:
          return const HomePage();
          break;
        case 1:
          return const ChatPage();
          break;
        case 2:
          return const WishlistPage();
          break;
        case 3:
          return const ProfilePage();
          break;
        default:
      }
      return const HomePage();
    }

    return Scaffold(
        backgroundColor: pageProvider.currentIndex == 0
            ? backgroundColor1
            : backgroundColor3,
        floatingActionButton: cartButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: customeBottomNav(),
        body: body());
  }
}
