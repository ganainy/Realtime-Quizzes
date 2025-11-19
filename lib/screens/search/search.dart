import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:realtime_quizzes/screens/friends/friends_controller.dart';
import 'package:realtime_quizzes/screens/search/search_controller.dart';
import 'package:shimmer/shimmer.dart';

import '../../customization/theme.dart';
import '../../models/UserStatus.dart';
import '../../models/download_state.dart';
import '../../models/user.dart';
import '../../shared/components.dart';
import '../../shared/modern_ui.dart';
import '../../shared/shared.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final TextEditingController searchTextEditingController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final GameSearchController searchController =
      Get.find<GameSearchController>();
  final FriendsController friendsController = Get.find<FriendsController>();

  @override
  Widget build(BuildContext context) {
    return ModernScaffold(
      body: Obx(() {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ModernHeader(
                  title: 'search'.tr,
                  subtitle: 'find_friends_and_players'.tr,
                ),
                const SizedBox(height: 24),
                searchController.downloadStateObs.value == DownloadState.LOADING
                    ? _buildShimmerLoadingView(context)
                    : searchController.downloadStateObs.value ==
                            DownloadState.INITIAL
                        ? _buildInitialView(context, 'find_user_message'.tr)
                        : searchController.downloadStateObs.value ==
                                DownloadState.EMPTY
                            ? _buildInitialView(context, 'no_matches_found'.tr)
                            : _buildResultsView(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSearchField() {
    return ModernTextField(
      hintText: 'search_by_name_or_email'.tr,
      controller: searchTextEditingController,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.search),
      suffixIcon: IconButton(
        onPressed: () {
          _search();
        },
        icon: const Icon(Icons.arrow_forward),
      ),
      onSubmitted: (_) {
        _search();
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'enter_query'.tr;
        }
        return null;
      },
    );
  }

  void _search() {
    if (_formKey.currentState!.validate()) {
      searchController.searchQueryObs.value =
          searchTextEditingController.value.text;
      searchController.findUserMatches();
    }
  }

  Widget _buildResultsView() {
    return Column(
      children: [
        _buildSearchField(),
        const SizedBox(height: 24),
        ListView.separated(
          itemBuilder: (context, index) {
            var currentUser = searchController.queryResultsObs.elementAt(index);
            return _buildUserResultItem(context, currentUser);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 12);
          },
          itemCount: searchController.queryResultsObs.length,
          shrinkWrap: true,
          primary: false,
        ),
      ],
    );
  }

  Widget _buildUserResultItem(BuildContext context, UserModel currentUser) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ModernContentCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          DefaultCircularNetworkImage(
            imageUrl: currentUser.imageUrl,
            width: 50,
            height: 50,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentUser.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? primaryTextDark : primaryTextLight,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  currentUser.email ?? '',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? secondaryTextDark : secondaryTextLight,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          _buildInteractButton(currentUser),
        ],
      ),
    );
  }

  Widget _buildInteractButton(UserModel? currentUser) {
    var text;
    var connection = Shared.loggedUser?.connections.firstWhereOrNull(
        (connection) => connection?.email == currentUser?.email);

    var status;
    if (connection == null) {
      status = UserStatus.NOT_FRIEND;
    } else {
      status = connection.userStatus;
    }

    switch (status) {
      case UserStatus.NOT_FRIEND:
        text = 'add'.tr;
        break;
      case UserStatus.FRIEND:
        text = 'friend'.tr;
        break;
      case UserStatus.SENT_FRIEND_REQUEST:
        text = 'sent'.tr;
        break;
      case UserStatus.RECEIVED_FRIEND_REQUEST:
        text = 'accept'.tr;
        break;
      case UserStatus.REMOVED_REQUEST:
        text = 'add'.tr;
        break;
      default:
        text = 'add'.tr;
        break;
    }

    final isActionable = status == UserStatus.NOT_FRIEND ||
        status == UserStatus.RECEIVED_FRIEND_REQUEST ||
        status == UserStatus.REMOVED_REQUEST;

    return SizedBox(
      height: 36,
      child: ElevatedButton(
        onPressed: () {
          searchController.interactWithUser(currentUser, status);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isActionable ? primaryColor : Colors.grey.withOpacity(0.2),
          foregroundColor: isActionable ? Colors.white : Colors.grey,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildShimmerLoadingView(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.white10 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.white24 : Colors.grey.shade100;

    return Column(
      children: [
        _buildSearchField(),
        const SizedBox(height: 24),
        ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ModernContentCard(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: const CircleAvatar(radius: 25),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highlightColor,
                          child: Container(
                            height: 16,
                            width: 120,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highlightColor,
                          child: Container(
                            height: 12,
                            width: 180,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 12);
          },
          itemCount: 3,
        ),
      ],
    );
  }

  Widget _buildInitialView(BuildContext context, String msg) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSearchField(),
        const SizedBox(height: 48),
        Icon(
          Icons.search,
          size: 80,
          color: isDark
              ? secondaryTextDark.withOpacity(0.3)
              : secondaryTextLight.withOpacity(0.3),
        ),
        const SizedBox(height: 24),
        Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isDark ? primaryTextDark : primaryTextLight,
          ),
        ),
      ],
    );
  }
}
