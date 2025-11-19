import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../customization/theme.dart';
import '../../main_controller.dart';
import '../../shared/components.dart';
import '../../shared/modern_ui.dart';
import '../../layouts/home/home_controller.dart';
import 'friends_controller.dart';

class FriendsScreen extends StatelessWidget {
  FriendsScreen({Key? key}) : super(key: key);

  final FriendsController friendsController = Get.find<FriendsController>();
  final MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ModernScaffold(
      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ModernHeader(
                title: (friendsController.friendsObs.isEmpty &&
                        friendsController.receivedFriendRequestsObs.isEmpty)
                    ? ''
                    : 'friends'.tr,
                subtitle: (friendsController.friendsObs.isEmpty &&
                        friendsController.receivedFriendRequestsObs.isEmpty)
                    ? ''
                    : 'connect_and_play'.tr,
              ),
              const SizedBox(height: 32),

              // Friends Horizontal List
              _buildFriendsList(context, isDark),
              const SizedBox(height: 32),

              // Friend Requests Section
              if (friendsController.receivedFriendRequestsObs.isNotEmpty)
                _buildFriendRequests(context, isDark),

              // Empty State
              if (friendsController.friendsObs.isEmpty &&
                  friendsController.receivedFriendRequestsObs.isEmpty)
                _buildEmptyState(context, isDark),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildFriendsList(BuildContext context, bool isDark) {
    // Only show friends list if there are friends
    if (friendsController.friendsObs.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 110,
      child: Center(
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            // Friends
            ...friendsController.friendsObs.map((friend) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: _buildFriendAvatar(context, friend, isDark),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendAvatar(BuildContext context, dynamic friend, bool isDark) {
    return InkWell(
      onTap: () {
        mainController.showFriendDialog(friend);
      },
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: friend.isOnline == true
                        ? friendsBlue
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: DefaultCircularNetworkImage(
                  imageUrl: friend.imageUrl,
                  width: 64,
                  height: 64,
                ),
              ),
              if (friend.isOnline == true)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark ? backgroundDark : backgroundLight,
                        width: 2,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 64,
            child: Text(
              friend.name ?? 'Friend',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? secondaryTextDark : secondaryTextLight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendRequests(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ModernSectionTitle(title: 'friend_requests'.tr),
        const SizedBox(height: 16),
        ...friendsController.receivedFriendRequestsObs.map((request) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildFriendRequestCard(context, request, isDark),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildFriendRequestCard(
      BuildContext context, dynamic request, bool isDark) {
    return ModernContentCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Avatar
          DefaultCircularNetworkImage(
            imageUrl: request.imageUrl,
            width: 48,
            height: 48,
          ),
          const SizedBox(width: 16),

          // Name and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.name ?? 'User',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? primaryTextDark : primaryTextLight,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'wants_to_be_friend'.tr,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? secondaryTextDark : secondaryTextLight,
                  ),
                ),
              ],
            ),
          ),

          // Action buttons
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  mainController.acceptFriendRequest(request);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: friendsBlue,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'accept'.tr,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  mainController.removeFriendRequest(request);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? surfaceDark : Colors.grey.shade200,
                  foregroundColor: isDark ? Colors.white70 : Colors.black54,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'remove'.tr,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48.0),
      child: Column(
        children: [
          Icon(
            Icons.group_off,
            size: 64,
            color: isDark ? secondaryTextDark : secondaryTextLight,
          ),
          const SizedBox(height: 16),
          Text(
            'no_friends_yet'.tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDark ? primaryTextDark : primaryTextLight,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'find_friends_message'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? secondaryTextDark : secondaryTextLight,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ModernButton(
            text: 'discover_friends'.tr,
            onPressed: () {
              // Navigate to search tab (index 3)
              final homeController = Get.find<HomeController>();
              homeController.navigateBottomsheet(3);
            },
          ),
        ],
      ),
    );
  }
}
