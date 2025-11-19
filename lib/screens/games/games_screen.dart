import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_quizzes/models/game.dart';
import 'package:realtime_quizzes/screens/games/games_controller.dart';

import '../../customization/theme.dart';
import '../../main_controller.dart';
import '../../models/download_state.dart';
import '../../models/user.dart';
import '../../shared/components.dart';
import '../../shared/modern_ui.dart';
import '../crate_game/create_game.dart';

class GamesScreen extends StatelessWidget {
  GamesScreen({Key? key}) : super(key: key);

  final GamesController gamesController = Get.put(GamesController());
  final MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return ModernScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CreateGameScreen());
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
        elevation: 4,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ModernHeader(
                title: gamesController.downloadStateObs.value ==
                        DownloadState.EMPTY
                    ? ''
                    : 'games'.tr,
                subtitle: gamesController.downloadStateObs.value ==
                        DownloadState.EMPTY
                    ? ''
                    : 'join_game_to_start'.tr,
              ),
              const SizedBox(height: 24),

              gamesController.downloadStateObs.value == DownloadState.LOADING
                  ? _buildLoadingView()
                  : gamesController.downloadStateObs.value ==
                          DownloadState.EMPTY
                      ? _buildEmptyView(context)
                      : gamesController.downloadStateObs.value ==
                              DownloadState.ERROR
                          ? _buildErrorView(context)
                          : _buildAvailableGamesView(context),

              const SizedBox(height: 80), // Space for FAB
            ],
          ),
        );
      }),
    );
  }

  Widget _buildAvailableGamesView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (gamesController.friendsGamesObs.value.isNotEmpty) ...[
          ModernSectionTitle(title: 'friends_games'.tr),
          const SizedBox(height: 12),
          _buildGamesList(context, gamesController.friendsGamesObs.value),
          const SizedBox(height: 24),
        ],
        ModernSectionTitle(title: 'other_games'.tr),
        const SizedBox(height: 12),
        gamesController.availableGamesObs.value.isEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'no_other_games'.tr,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? secondaryTextDark
                        : secondaryTextLight,
                  ),
                ),
              )
            : _buildGamesList(context, gamesController.availableGamesObs.value),
      ],
    );
  }

  Widget _buildGamesList(BuildContext context, List<dynamic> gamesList) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: gamesList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _buildGameItem(context, gamesList[index]);
      },
    );
  }

  Widget _buildGameItem(BuildContext context, GameModel game) {
    UserModel? creator = game.players
        ?.firstWhere((player) => player?.user?.email == game.gameId)
        ?.user;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ModernContentCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          mainController.joinGame(game);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              DefaultCircularNetworkImage(
                imageUrl: creator?.imageUrl,
                width: 50,
                height: 50,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          creator?.name ?? 'Unknown',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDark ? primaryTextDark : primaryTextLight,
                          ),
                        ),
                        Text(
                          formatTimeAgo(game.gameSettings?.createdAt),
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                isDark ? secondaryTextDark : secondaryTextLight,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildInfoChip(
                          '${game.gameSettings?.difficulty}',
                          _getDifficultyColor(game.gameSettings?.difficulty),
                        ),
                        _buildInfoChip(
                          '${game.gameSettings?.category}',
                          primaryColor,
                        ),
                        _buildInfoChip(
                          '${game.gameSettings?.numberOfQuestions?.toInt() ?? 10} Qs',
                          Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: isDark ? secondaryTextDark : secondaryTextLight,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.5), width: 1),
      ),
      child: Text(
        label.capitalize ?? label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  Color _getDifficultyColor(String? difficulty) {
    switch (difficulty?.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return primaryColor;
    }
  }

  Widget _buildLoadingView() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildEmptyView(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48.0),
        child: Column(
          children: [
            Icon(
              Icons.games_outlined,
              size: 64,
              color: isDark ? secondaryTextDark : secondaryTextLight,
            ),
            const SizedBox(height: 16),
            Text(
              'no_games_available'.tr,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark ? primaryTextDark : primaryTextLight,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'create_new_game'.tr,
              style: TextStyle(
                color: isDark ? secondaryTextDark : secondaryTextLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context) {
    return Center(
      child: Text(
        'Something went wrong.',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
