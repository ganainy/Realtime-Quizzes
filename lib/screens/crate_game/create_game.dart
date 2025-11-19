import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Modern UI redesign with vibrant indigo theme
import '../../customization/theme.dart';
import '../../main_controller.dart';
import '../../models/game_type.dart';
import '../../shared/constants.dart';
import 'create_game_controller.dart';

class CreateGameScreen extends StatelessWidget {
  CreateGameScreen({Key? key}) : super(key: key);

  final CreateGameController createGameController =
      Get.put(CreateGameController());
  final MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = Theme.of(context).brightness == Brightness.dark;

      return SafeArea(
        child: Scaffold(
          backgroundColor: isDark ? backgroundDark : backgroundLight,
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 448), // max-w-md
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Header
                      _buildHeader(context, isDark),
                      const SizedBox(height: 24),

                      // Main content
                      _buildCategoriesSection(context, isDark),
                      const SizedBox(height: 24),
                      _buildQuestionAmountSection(context, isDark),
                      const SizedBox(height: 24),
                      _buildDifficultySection(context, isDark),
                      const SizedBox(height: 24),
                      _buildGameModeSection(context, isDark),
                      const SizedBox(height: 16),

                      // Create button
                      _buildCreateButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        children: [
          Text(
            'Game settings',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: isDark ? primaryTextDark : primaryTextLight,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Create game and wait for opponent to join',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? secondaryTextDark : secondaryTextLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context, bool isDark) {
    // Show only first 4 categories: Random, General, Books, Films
    final displayCategories = Constants.categoryList.take(4).toList();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? surfaceDark : surfaceLight,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDark ? primaryTextDark : primaryTextLight,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: displayCategories.length,
            itemBuilder: (context, index) {
              final category = displayCategories[index];
              final isSelected =
                  mainController.gameObs.value?.gameSettings?.category ==
                      category['category'];

              return _buildCategoryButton(
                context,
                category['category'],
                isSelected,
                isDark,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(
    BuildContext context,
    String categoryName,
    bool isSelected,
    bool isDark,
  ) {
    return Material(
      color: isSelected
          ? primaryColor
          : (isDark ? backgroundDark : backgroundLight),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () {
          mainController.gameObs.value?.gameSettings?.category = categoryName;
          mainController.forceUpdateUi();
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            categoryName,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? Colors.white
                  : (isDark ? secondaryTextDark : secondaryTextLight),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionAmountSection(BuildContext context, bool isDark) {
    final questionCount =
        mainController.gameObs.value?.gameSettings?.numberOfQuestions?.ceil() ??
            10;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? surfaceDark : surfaceLight,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question amount',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isDark ? primaryTextDark : primaryTextLight,
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$questionCount',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor:
                  isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
              inactiveTrackColor:
                  isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
              thumbColor: primaryColor,
              overlayColor: primaryColor.withOpacity(0.2),
              trackHeight: 8,
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 14,
                elevation: 0,
              ),
            ),
            child: Slider(
              min: 1,
              max: 20,
              value: questionCount.toDouble(),
              onChanged: (value) {
                mainController.gameObs.value?.gameSettings?.numberOfQuestions =
                    value;
                mainController.forceUpdateUi();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultySection(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? surfaceDark : surfaceLight,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Difficulty',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDark ? primaryTextDark : primaryTextLight,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDifficultyOption('easy'.tr, Colors.green.shade500, isDark),
              _buildDifficultyOption(
                  'medium'.tr, Colors.yellow.shade400, isDark),
              _buildDifficultyOption('hard'.tr, Colors.red.shade500, isDark),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyOption(String difficulty, Color color, bool isDark) {
    final isSelected =
        mainController.gameObs.value?.gameSettings?.difficulty == difficulty;

    return InkWell(
      onTap: () {
        mainController.gameObs.value?.gameSettings?.difficulty = difficulty;
        mainController.forceUpdateUi();
      },
      borderRadius: BorderRadius.circular(50),
      child: Column(
        children: [
          Transform.scale(
            scale: isSelected ? 1.15 : 1.0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.25),
                          blurRadius: 0,
                          spreadRadius: 4,
                        ),
                      ]
                    : [],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            difficulty.capitalize ?? difficulty,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? secondaryTextDark : secondaryTextLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameModeSection(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? surfaceDark : surfaceLight,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Game mode',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDark ? primaryTextDark : primaryTextLight,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isDark ? backgroundDark : backgroundLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildGameModeButton(
                    'Multi player',
                    GameType.MULTI,
                    isDark,
                  ),
                ),
                Expanded(
                  child: _buildGameModeButton(
                    'Single player',
                    GameType.SINGLE,
                    isDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameModeButton(String text, GameType mode, bool isDark) {
    final isSelected = createGameController.gameTypeObs.value == mode;

    return Material(
      color: isSelected ? primaryColor : Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        onTap: () {
          createGameController.gameTypeObs.value = mode;
        },
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? Colors.white
                  : (isDark ? secondaryTextDark : secondaryTextLight),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          createGameController.createGame();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: const Text(
          'Create game',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
