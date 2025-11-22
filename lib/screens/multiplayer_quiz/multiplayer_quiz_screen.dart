import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_quizzes/customization/theme.dart';
import 'package:realtime_quizzes/main_controller.dart';
import 'package:realtime_quizzes/screens/multiplayer_quiz/multiplayer_quiz_controller.dart';
import 'package:realtime_quizzes/shared/components.dart';

class MultiPlayerQuizScreen extends StatelessWidget {
  MultiPlayerQuizScreen({Key? key}) : super(key: key);

  final MultiPlayerQuizController multiPlayerQuizController =
      Get.put(MultiPlayerQuizController());

  final MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (!didPop) {
          mainController.confirmExitDialog(isOnlineGame: true);
        }
      },
      child: SafeArea(child: Scaffold(
        body: Obx(() {
          return multiPlayerQuizController.gameObs.value == null
              ? const Center(child: CircularProgressIndicator())
              : Question(multiPlayerQuizController, context);
        }),
      )),
    );
  }

  Question(
    MultiPlayerQuizController multiPlayerQuizController,
    BuildContext context,
  ) {
    var currentQuestion = multiPlayerQuizController.gameObs.value!.questions!
        .elementAt(multiPlayerQuizController.currentQuestionIndexObs.value);

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const SizedBox(height: mediumPadding),
                    DefaultCircularNetworkImage(
                        imageUrl: multiPlayerQuizController
                            .loggedPlayer?.user?.imageUrl),
                    const SizedBox(height: 8),
                    Text(
                      (multiPlayerQuizController
                                  .loggedPlayer?.user?.name?.isEmpty ??
                              true)
                          ? 'Unknown'
                          : multiPlayerQuizController.loggedPlayer!.user!.name!,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${multiPlayerQuizController.loggedPlayer?.score} ',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.access_alarm,
                      size: 40,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    Text(
                      multiPlayerQuizController.timerValueObs.value.toString(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color:
                              multiPlayerQuizController.timerValueObs.value <= 3
                                  ? Colors.red
                                  : Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.color),
                    ),
                  ],
                ),
                Column(
                  children: [
                    DefaultCircularNetworkImage(
                        imageUrl:
                            multiPlayerQuizController.opponent?.user?.imageUrl),
                    const SizedBox(height: 8),
                    Text(
                      (multiPlayerQuizController
                                  .opponent?.user?.name?.isEmpty ??
                              true)
                          ? 'Unknown'
                          : multiPlayerQuizController.opponent!.user!.name!,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${multiPlayerQuizController.opponent?.score} ',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(smallPadding),
                  child: Card(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF334155) // Darker slate for dark mode
                        : Colors.yellow[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(largePadding),
                        child: Text(
                          '${currentQuestion?.question}',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black87,
                                    fontWeight: FontWeight.w600,
                                  ),
                        )),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF1E293B)
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        'Question: ${(multiPlayerQuizController.currentQuestionIndexObs.value + 1)}'
                        '/${(multiPlayerQuizController.gameObs.value?.questions?.length)}',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white70
                              : Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ...?currentQuestion?.allAnswers.map((answer) {
              return Answer(answer, multiPlayerQuizController, context);
            }),
            /* Text(
                'temporary text right answer: ${currentQuestion?.correctAnswer}'),*/
          ],
        ),
      ),
    );
  }

  Answer(
    String text /*answer*/,
    MultiPlayerQuizController multiPlayerQuizController,
    BuildContext context,
  ) {
    return MultiPlayerAnswerButton(
        text: text,
        context: context,
        loggedPlayerImageUrl:
            multiPlayerQuizController.loggedPlayer?.user?.imageUrl,
        otherPlayerImageUrl: multiPlayerQuizController.opponent?.user?.imageUrl,
        onPressed: () {
          //if question is already answered do nothing
          if (multiPlayerQuizController.isQuestionNotAnswered()) {
            multiPlayerQuizController.registerAnswer(
              text,
            );
          }
        },
        multiPlayerQuizController: multiPlayerQuizController);
  }
}
