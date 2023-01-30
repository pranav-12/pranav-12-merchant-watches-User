import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:provider/provider.dart';
import '../../appication/bottom_nav_bar_provider.dart';
import '../../constants/constants.dart';
import '../cart/screen_cart.dart';
import '../home/screen_home.dart';
import '../profile/screen_profile.dart';
import '../wishlist/screen_wishlist.dart';

class CustomBNavBar extends StatelessWidget {
  CustomBNavBar({
    super.key,
  });
// List for bottom nav bar items
  final List<BottomNavigationBarItem> iconListForBNavBarList = [
    const BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(
        Icons.home_outlined,
        size: 30,
      ),
    ),
    BottomNavigationBarItem(
      label: 'Cart',
      icon: badges.Badge(
        ignorePointer: true,
        position: BadgePosition.custom(top: -15, start: 20),
        badgeStyle: const BadgeStyle(
          badgeColor: Colors.black,
          shape: BadgeShape.circle,
        ),
        badgeContent: ValueListenableBuilder(
          valueListenable: cartDataList,
          builder: (context, value, child) => Text(
            value.isNotEmpty ? value.length.toString() : "",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child: const Icon(
          Icons.shopping_cart_outlined,
          size: 30,
        ),
      ),
    ),
    const BottomNavigationBarItem(
      label: 'WishList',
      icon: Icon(
        Icons.favorite_border,
        size: 30,
      ),
    ),
    const BottomNavigationBarItem(
      label: 'Profile',
      icon: Icon(
        Icons.person_outlined,
        size: 30,
      ),
    ),
  ];

// pages for body showing the content of the screen
  final List pages = [
    ScreenHome(),
    const ScreenCart(),
    const ScreenWishList(),
    const ScreenProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavBarProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: SnakeNavigationBar.color(
            showSelectedLabels: true,
            items: iconListForBNavBarList,
            unselectedItemColor: Colors.white,
            selectedItemColor: primaryFontColor,
            backgroundColor: primaryBackgroundColor,
            snakeShape: SnakeShape.indicator,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            currentIndex: value.selectedCurrentIndex,
            height: 70,
            onTap: (index) => value.bottomNavigationChange(index),
            snakeViewColor: primaryBackgroundColor,
          ),
        ),
        body: pages[value.selectedCurrentIndex],
      ),
    );
  }
}
