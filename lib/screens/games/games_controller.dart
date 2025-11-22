import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:realtime_quizzes/main_controller.dart';
import 'package:realtime_quizzes/models/game.dart';

import '../../models/download_state.dart';
import '../../shared/shared.dart';

class GamesController extends GetxController {
  var downloadStateObs = DownloadState.INITIAL.obs;
  var availableGamesObs = [].obs; // list of gameModel by strangers
  var friendsGamesObs = [].obs; // list of gameModel by friends

  var createdGameObs = Rxn<GameModel>();

  late MainController mainController;
  @override
  void onInit() {
    mainController = Get.find<MainController>();
    loadAvailableGames();
  }

  //this method will be triggered if this player is matched with another player
  void loadAvailableGames() {
    debugPrint("loadAvailableGames");

    downloadStateObs.value = DownloadState.LOADING;
    gameCollection.snapshots().listen((event) {
      createdGameObs.value = null; // Reset created game

      if (event.docs.isEmpty) {
        downloadStateObs.value = DownloadState.EMPTY;
        return;
      }
      downloadStateObs.value = DownloadState.SUCCESS;

      var tempAvailableGames = [];

      for (var gameJson in event.docs) {
        var game = GameModel.fromJson(gameJson.data());

        // Check if this is the user's created game
        if (game.gameId == Shared.loggedUser?.email) {
          if (game.gameStatus == GameStatus.ACTIVE) {
            createdGameObs.value = game;
          }
        } else {
          // Not user's game, add to available games
          tempAvailableGames.add(game);

          if (game.gameStatus == GameStatus.ACTIVE && !isShowedGame(game)) {
            //this means game was added
            availableGamesObs.value.add(game);
            availableGamesObs.refresh();
          }
        }
      }

      if (tempAvailableGames.length < availableGamesObs.value.length) {
        //this means a game was removed
        availableGamesObs.value = tempAvailableGames;
        availableGamesObs.refresh();
      }

      if (Shared.loggedUser!.connections.isEmpty) {
        //this user has no friends, so no friends games
        return;
      }

      //set friends games
      friendsGamesObs.value.clear();
      friendsGamesObs.refresh();
      for (var availableGame in availableGamesObs.value) {
        if (Shared.loggedUser!.connections.map((connection) {
          return connection?.email;
        }).contains(availableGame.gameId)) {
          availableGamesObs.value.remove(availableGame);
          availableGamesObs.refresh();
          friendsGamesObs.value.add(availableGame);
          friendsGamesObs.refresh();
        }
      }

      if (availableGamesObs.value.isEmpty &&
          friendsGamesObs.value.isEmpty &&
          createdGameObs.value == null) {
        //there is only one game and its created by logged user so dont show
        downloadStateObs.value = DownloadState.EMPTY;
      }
    }).onError((error, stackTrace) {
      mainController.errorDialog('Error loading games: ' + error.toString());
      printError(
          info: 'Scenario 1: searchAvailableQueues error :' + error.toString());
    });
  }

  //checks if game is already downloaded
  bool isShowedGame(GameModel newGame) {
    bool isShowed = false;
    for (var game in availableGamesObs.value) {
      if (newGame.gameId == game.gameId) {
        isShowed = true;
      }
    }
    return isShowed;
  }

  void cancelCreatedGame() {
    if (createdGameObs.value != null) {
      mainController.loadingDialog(loadingMessage: 'Canceling game...');
      gameCollection.doc(createdGameObs.value!.gameId).delete().then((value) {
        mainController.hideCurrentDialog();
        createdGameObs.value = null;
        // Refresh the list to ensure UI updates
        loadAvailableGames();
      }).catchError((error) {
        mainController.hideCurrentDialog();
        mainController.errorDialog('Failed to cancel game: $error');
      });
    }
  }
}
