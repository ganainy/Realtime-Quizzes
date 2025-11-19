import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_quizzes/customization/theme.dart';
import 'package:realtime_quizzes/main_controller.dart';

import '../../models/result.dart';
import '../../shared/components.dart';
import '../../shared/modern_ui.dart';
import '../../shared/shared.dart';
import '../login/login.dart';
import 'profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ModernScaffold(
      body: Obx(() {
        final singlePlayerGames =
            profileController.singlePlayerResultsObs.value ?? [];
        final multiPlayerGames =
            profileController.multiPlayerResultsObs.value ?? [];
        final totalGames = singlePlayerGames.length + multiPlayerGames.length;
        final wonGames = profileController.multiPlayerWonGamesCount.value;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // User Profile Card
              ModernContentCard(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryColor, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: DefaultCircularNetworkImage(
                          imageUrl: Shared.loggedUser?.imageUrl,
                          width: 100.0,
                          height: 100.0,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${Shared.loggedUser?.name}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark ? primaryTextDark : primaryTextLight,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${Shared.loggedUser?.email}',
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              isDark ? secondaryTextDark : secondaryTextLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Stats Summary
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      context,
                      title: 'total_games'.tr,
                      value: '$totalGames',
                      icon: Icons.sports_esports,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      title: 'won_online'.tr,
                      value: '$wonGames',
                      icon: Icons.emoji_events,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Language Selector
              ModernContentCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.language,
                          color: primaryColor,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'language'.tr,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isDark ? primaryTextDark : primaryTextLight,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildLanguageOption(
                            context,
                            label: 'english'.tr,
                            locale: const Locale('en', 'US'),
                            flag: '🇺🇸',
                            isDark: isDark,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildLanguageOption(
                            context,
                            label: 'german'.tr,
                            locale: const Locale('de', 'DE'),
                            flag: '🇩🇪',
                            isDark: isDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Game History
              if (profileController.multiPlayerResultsObs.value == null &&
                  profileController.singlePlayerResultsObs.value == null)
                const Center(child: CircularProgressIndicator())
              else ...[
                ModernSectionTitle(title: 'game_history'.tr),
                const SizedBox(height: 12),
                _buildGameSection(
                  context,
                  title: 'offline_games'.tr,
                  subtitle: '${singlePlayerGames.length} ${'games_played'.tr}',
                  games: singlePlayerGames,
                  isDark: isDark,
                ),
                const SizedBox(height: 16),
                _buildGameSection(
                  context,
                  title: 'online_games'.tr,
                  subtitle:
                      '$wonGames ${'won_of'.tr} ${multiPlayerGames.length} ${'played'.tr}',
                  games: multiPlayerGames,
                  isDark: isDark,
                ),
              ],

              const SizedBox(height: 40),

              // Sign Out Button
              ModernButton(
                text: 'sign_out'.tr,
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Get.offAll(() => LoginScreen());
                  Get.delete<MainController>();
                },
                backgroundColor: Colors.red.shade500,
                textColor: Colors.white,
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ModernContentCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? primaryTextDark : primaryTextLight,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? secondaryTextDark : secondaryTextLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameSection(
    BuildContext context, {
    required String title,
    required String subtitle,
    required List<dynamic> games,
    required bool isDark,
  }) {
    return ModernContentCard(
      padding: EdgeInsets.zero,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? primaryTextDark : primaryTextLight,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? secondaryTextDark : secondaryTextLight,
            ),
          ),
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: games.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: isDark ? Colors.white10 : Colors.black12,
              ),
              itemBuilder: (context, index) {
                return _buildGameResultItem(context, games[index], isDark);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameResultItem(
      BuildContext context, ResultModel result, bool isDark) {
    Color statusColor;
    IconData statusIcon;

    if (result.type == 'win') {
      statusColor = Colors.green;
      statusIcon = Icons.emoji_events;
    } else if (result.type == 'draw') {
      statusColor = Colors.orange;
      statusIcon = Icons.handshake;
    } else {
      statusColor = Colors.red;
      statusIcon = Icons.close;
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(statusIcon, size: 16, color: statusColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.category ?? 'Random',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isDark ? primaryTextDark : primaryTextLight,
                      ),
                    ),
                    Text(
                      '${result.difficulty} • ${formatTimeAgo(result.createdAt)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? secondaryTextDark : secondaryTextLight,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${result.score}/${result.maxScore}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? primaryTextDark : primaryTextLight,
                    ),
                  ),
                  Text(
                    'Score',
                    style: TextStyle(
                      fontSize: 10,
                      color: isDark ? secondaryTextDark : secondaryTextLight,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Score Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Row(
              children: [
                Expanded(
                  flex: result.score ?? 0,
                  child: Container(height: 6, color: Colors.green),
                ),
                Expanded(
                  flex: (result.maxScore ?? 0) - (result.score ?? 0),
                  child:
                      Container(height: 6, color: Colors.red.withOpacity(0.3)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context, {
    required String label,
    required Locale locale,
    required String flag,
    required bool isDark,
  }) {
    final isSelected = Get.locale?.languageCode == locale.languageCode;

    return InkWell(
      onTap: () {
        Get.updateLocale(locale);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor.withOpacity(0.1)
              : (isDark ? surfaceDark : surfaceLight),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              flag,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? primaryColor
                    : (isDark ? primaryTextDark : primaryTextLight),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
