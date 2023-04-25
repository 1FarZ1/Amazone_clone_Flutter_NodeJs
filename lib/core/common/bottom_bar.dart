import 'package:amazon_clone/features/admin/view/widgets/custom_app_bar_admin.dart';
import 'package:badges/badges.dart' as b;
import 'package:flutter/material.dart';

import '../constant/constants.dart';

class BottomBar extends StatefulWidget {
  final List<Widget> paramPages;

  const BottomBar({Key? key, required this.paramPages}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState(paramPages);
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  final List<Widget> pages;

  _BottomBarState(this.pages);

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarAdmin(),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: AppConsts.selectedNavBarColor,
        unselectedItemColor: const Color.fromARGB(221, 255, 255, 255),
        backgroundColor: const Color.fromARGB(255, 20, 230, 195),
        iconSize: 28,
        onTap: updatePage,
        items: [
          // HOME
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? AppConsts.selectedNavBarColor
                        : const Color.fromARGB(255, 20, 230, 195),
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            label: '',
          ),
          // ACCOUNT
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? AppConsts.selectedNavBarColor
                        : const Color.fromARGB(255, 20, 230, 195),
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.person_outline_outlined,
              ),
            ),
            label: '',
          ),
          // CART
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? AppConsts.selectedNavBarColor
                        : const Color.fromARGB(255, 20, 230, 195),
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: b.Badge(
                position: b.BadgePosition.topEnd(top: 0, end: 0),
                showBadge: true,
                badgeStyle: b.BadgeStyle(
                  padding: const EdgeInsets.all(7),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  badgeColor: !(_page == 2)
                      ? const Color.fromARGB(255, 255, 255, 255)
                      : AppConsts.selectedNavBarColor,
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                ),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}

//
//