import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_quizzes/customization/theme.dart';
import 'package:realtime_quizzes/screens/games/games_screen.dart';
import 'package:realtime_quizzes/screens/search/search.dart';

import '../../screens/friends/friends.dart';
import '../../screens/profile/profile.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: Obx(() {
        return _buildModernBottomNav(context, isDark);
      }),
    );
  }

  Widget _buildModernBottomNav(BuildContext context, bool isDark) {
    final currentIndex = homeController.bottomSelectedIndex.value;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context: context,
                icon: Icons.grid_view_rounded,
                label: 'home'.tr,
                index: 0,
                isSelected: currentIndex == 0,
                isDark: isDark,
              ),
              _buildNavItem(
                context: context,
                icon: Icons.people_outline,
                label: 'friends'.tr,
                index: 1,
                isSelected: currentIndex == 1,
                isDark: isDark,
              ),
              _buildNavItem(
                context: context,
                icon: Icons.person_outline,
                label: 'profile_tab'.tr,
                index: 2,
                isSelected: currentIndex == 2,
                isDark: isDark,
              ),
              _buildNavItem(
                context: context,
                icon: Icons.search,
                label: 'search'.tr,
                index: 3,
                isSelected: currentIndex == 3,
                isDark: isDark,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
    required bool isDark,
  }) {
    final selectedColor = friendsBlue;
    final unselectedColor =
        isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8);

    return Expanded(
      child: InkWell(
        onTap: () {
          homeController.navigateBottomsheet(index);
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          // Removed padding to prevent overflow
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 24,
                color: isSelected ? selectedColor : unselectedColor,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? selectedColor : unselectedColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.grid_view_rounded),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.people_outline),
        label: 'Friends',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person_outline),
        label: 'Profile',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Search',
      ),
    ];
  }

  Widget buildPageView() {
    return PageView(
      controller: homeController.pageController,
      onPageChanged: (index) {
        homeController.bottomSelectedIndex.value = index;
      },
      children: <Widget>[
        GamesScreen(),
        FriendsScreen(),
        ProfileScreen(),
        SearchScreen(),
      ],
    );
  }
}
