import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_quizzes/layouts/home/home.dart';
import 'package:realtime_quizzes/main_controller.dart';
import 'package:realtime_quizzes/models/quiz_settings.dart';
import 'package:realtime_quizzes/screens/result/result_controller.dart';
import 'package:realtime_quizzes/shared/components.dart';
import 'package:realtime_quizzes/shared/modern_ui.dart';

import '../../customization/theme.dart';
import '../../models/game_type.dart';
import '../../shared/shared.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({Key? key}) : super(key: key);

  final ResultController resultController =
      Get.put(ResultController(Get.arguments));
  final MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return ModernScaffold(
      body: SafeArea(
        child: Get.arguments['gameType'] == GameType.MULTI
            ? _buildMultiPlayerResult(context)
            : _buildSinglePlayerResult(
                gameSettings: Get.arguments['gameSettings'],
                finalScore: Get.arguments['finalScore'],
                context: context),
      ),
    );
  }

  Widget _buildMultiPlayerResult(BuildContext context) {
    var game = resultController.gameObs.value;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Final Result',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: isDark ? primaryTextDark : primaryTextLight,
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Center(
              child: ModernContentCard(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildPlayerResult(
                        context,
                        game?.players!.elementAt(0)?.user?.name,
                        game?.players!.elementAt(0)?.user?.imageUrl,
                        game!.players!.elementAt(0)!.score,
                        game.players!.elementAt(0)!.score >
                            game.players!.elementAt(1)!.score,
                      ),
                      Text(
                        'VS',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                      _buildPlayerResult(
                        context,
                        game.players!.elementAt(1)?.user?.name,
                        game.players!.elementAt(1)?.user?.imageUrl,
                        game.players!.elementAt(1)!.score,
                        game.players!.elementAt(1)!.score >
                            game.players!.elementAt(0)!.score,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ModernButton(
              text: 'Return Home',
              onPressed: () {
                mainController.deleteGame(game.gameId);
                Get.offAll(() => HomeScreen());
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPlayerResult(BuildContext context, String? name,
      String? imageUrl, int score, bool isWinner) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    isWinner ? Border.all(color: Colors.amber, width: 4) : null,
                boxShadow: isWinner
                    ? [
                        BoxShadow(
                          color: Colors.amber.withOpacity(0.5),
                          blurRadius: 20,
                          spreadRadius: 2,
                        )
                      ]
                    : null,
              ),
              child: DefaultCircularNetworkImage(
                imageUrl: imageUrl,
                width: 80,
                height: 80,
              ),
            ),
            if (isWinner)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.emoji_events,
                  color: Colors.white,
                  size: 16,
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          (name == null || name.isEmpty) ? 'Unknown' : name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? primaryTextDark : primaryTextLight,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isWinner
                ? Colors.amber.withOpacity(0.2)
                : Theme.of(context).dividerColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '$score pts',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isWinner
                  ? Colors.amber
                  : (isDark ? secondaryTextDark : secondaryTextLight),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSinglePlayerResult(
      {required GameSettings gameSettings,
      required int finalScore,
      required BuildContext context}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final percentage = (finalScore / gameSettings.numberOfQuestions!) * 100;
    Color scoreColor;
    if (percentage >= 80) {
      scoreColor = Colors.green;
    } else if (percentage >= 50) {
      scoreColor = Colors.orange;
    } else {
      scoreColor = Colors.red;
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Final Result',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: isDark ? primaryTextDark : primaryTextLight,
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Center(
              child: ModernContentCard(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: CircularProgressIndicator(
                              value: percentage / 100,
                              strokeWidth: 12,
                              backgroundColor: Theme.of(context)
                                  .dividerColor
                                  .withOpacity(0.1),
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(scoreColor),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '$finalScore',
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: scoreColor,
                                ),
                              ),
                              Text(
                                '/ ${gameSettings.numberOfQuestions!.toInt()}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isDark
                                      ? secondaryTextDark
                                      : secondaryTextLight,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Text(
                        percentage >= 80
                            ? 'Excellent!'
                            : percentage >= 50
                                ? 'Good Job!'
                                : 'Keep Trying!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark ? primaryTextDark : primaryTextLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ModernButton(
              text: 'Return Home',
              onPressed: () {
                mainController.deleteGame(Shared.game.gameId);
                Get.offAll(() => HomeScreen());
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
