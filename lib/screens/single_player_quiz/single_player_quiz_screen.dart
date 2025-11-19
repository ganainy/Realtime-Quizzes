import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_quizzes/customization/theme.dart';
import 'package:realtime_quizzes/main_controller.dart';
import 'package:realtime_quizzes/screens/single_player_quiz/single_player_quiz_controller.dart';

import '../../models/question.dart';
import '../../shared/shared.dart';

class SinglePlayerQuizScreen extends StatelessWidget {
  SinglePlayerQuizScreen({Key? key}) : super(key: key);

  final SinglePlayerQuizController singlePlayerQuizController =
      Get.put(SinglePlayerQuizController());

  final MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        mainController.confirmExitDialog();
        return Future.value(false);
      },
      child: Obx(() {
        return Scaffold(
          backgroundColor: quizBackgroundDark,
          body: singlePlayerQuizController.questions.value.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(quizPrimary),
                  ),
                )
              : _buildQuizContent(context),
        );
      }),
    );
  }

  Widget _buildQuizContent(BuildContext context) {
    if (singlePlayerQuizController.currentQuestionIndex.value >=
        singlePlayerQuizController.questions.value.length) {
      return const Center(child: CircularProgressIndicator());
    }

    QuestionModel currentQuestion = singlePlayerQuizController.questions.value
        .elementAt(singlePlayerQuizController.currentQuestionIndex.value);

    final totalQuestions = singlePlayerQuizController.questions.value.length;
    final currentIndex =
        singlePlayerQuizController.currentQuestionIndex.value + 1;
    final progress = currentIndex / totalQuestions;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header
            _buildHeader(context),
            const SizedBox(height: 16),

            // Progress Section
            _buildProgressSection(
                context, currentIndex, totalQuestions, progress),

            // Main Content
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildQuestionCard(
                      context, currentQuestion, currentIndex, totalQuestions),
                  const SizedBox(height: 32),
                  _buildAnswerButtons(context, currentQuestion),
                ],
              ),
            ),

            // Next/End Button
            const SizedBox(height: 16),
            _buildActionButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Close Button
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              mainController.confirmExitDialog();
            },
          ),
        ),

        // Score Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Score: ${singlePlayerQuizController.currentScore.value * 100}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Spacer
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildProgressSection(BuildContext context, int currentIndex,
      int totalQuestions, double progress) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Circular Timer
            _buildCircularTimer(),

            // Question Counter
            Row(
              children: [
                const Text(
                  'Question',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$currentIndex/$totalQuestions',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Progress Bar
        Container(
          height: 10,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: quizPrimary,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCircularTimer() {
    return Obx(() {
      final timerValue = singlePlayerQuizController.timerCounter.value ?? 10;
      final progress = timerValue / 10;

      return SizedBox(
        width: 64,
        height: 64,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 64,
              height: 64,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 4,
                backgroundColor: Colors.white.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(quizPrimary),
              ),
            ),
            Text(
              '$timerValue',
              style: TextStyle(
                color: timerValue <= 3 ? quizIncorrect : Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildQuestionCard(BuildContext context, QuestionModel question,
      int currentIndex, int totalQuestions) {
    return Column(
      children: [
        // Category Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: quizPrimary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: quizPrimary, width: 1),
          ),
          child: Text(
            Shared.game.gameSettings?.category?.toUpperCase() ?? 'TRIVIA',
            style: const TextStyle(
              color: quizPrimary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Question Text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            question.question ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerButtons(BuildContext context, QuestionModel question) {
    return Column(
      children: question.allAnswers.map((answer) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _buildAnswerButton(context, answer, question.correctAnswer!),
        );
      }).toList(),
    );
  }

  Widget _buildAnswerButton(
      BuildContext context, String answer, String correctAnswer) {
    return Obx(() {
      final isAnswered = singlePlayerQuizController.isQuestionAnswered.value;
      final isCorrect = answer == correctAnswer;
      final isSelected =
          singlePlayerQuizController.selectedAnswer.value == answer;

      Color buttonColor;
      Widget? trailingIcon;

      if (isAnswered) {
        if (isCorrect) {
          buttonColor = quizCorrect;
          trailingIcon = Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              color: quizCorrect,
              size: 20,
            ),
          );
        } else if (isSelected) {
          buttonColor = quizIncorrect;
          trailingIcon = Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.cancel,
              color: quizIncorrect,
              size: 20,
            ),
          );
        } else {
          buttonColor = quizSurfaceDark;
        }
      } else {
        buttonColor = quizSurfaceDark;
      }

      return Material(
        color: buttonColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: isAnswered
              ? null
              : () {
                  singlePlayerQuizController.checkAnswer(answer: answer);
                },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: (isAnswered && (isCorrect || isSelected))
                  ? Border.all(color: Colors.white.withOpacity(0.5), width: 2)
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    answer,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (trailingIcon != null) trailingIcon,
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildActionButton(BuildContext context) {
    return Obx(() {
      final isAnswered = singlePlayerQuizController.isQuestionAnswered.value;
      final isLastQuestion =
          singlePlayerQuizController.currentQuestionIndex.value >=
              singlePlayerQuizController.questions.value.length - 1;

      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (isLastQuestion || !isAnswered) {
              singlePlayerQuizController.endQuiz();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: quizPrimary,
            foregroundColor: Colors.black87,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
          ),
          child: Text(
            isLastQuestion ? 'View Results' : 'End Quiz',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    });
  }
}
