import 'package:get/get.dart';

class Constants {
  static Map<String, Map<String, String>> translation = {
    'en_US': {
      // Quiz Settings
      'num_questions': 'Number of Questions',
      'category': 'Category',
      'create_quiz': 'Create Quiz',
      'find_quiz': 'Find Quiz',
      'difficulty': 'Difficulty',

      // Categories
      'general_knowledge': 'General Knowledge',
      'books': 'Books',
      'films': 'Films',
      'music': 'Music',
      'musicals_and_theaters': 'Musicals & Theaters',
      'television': 'Television',
      'video_games': 'Video Games',
      'board_games': 'Board Games',
      'science_and_nature': 'Science & Nature',
      'computers': 'Computers',
      'mathematics': 'Mathematics',
      'mythology': 'Mythology',
      'sports': 'Sports',
      'geography': 'Geography',
      'history': 'History',
      'politics': 'Politics',
      'art': 'Art',
      'celebrities': 'Celebrities',
      'animals': 'Animals',

      // Difficulty
      'easy': 'Easy',
      'medium': 'Medium',
      'hard': 'Hard',

      // Error Messages
      'this_error_occurred_while_loading_quiz':
          'An error occurred while loading the quiz: ',
      'error_loading_quiz': 'Error Loading Quiz',

      // Authentication
      'continue_as_guest': 'Continue as Guest',
      'login': 'Login',
      'register': 'Register',
      'sign_out': 'Sign Out',
      'email': 'Email',
      'password': 'Password',
      'name': 'Name',
      'email_hint': 'Enter your email',
      'password_hint': 'Enter your password',
      'name_hint': 'Enter your name',
      'already_have_account': 'Already have an account?',
      'dont_have_account': "Don't have an account?",

      // Navigation
      'home': 'Home',
      'friends': 'Friends',
      'profile_tab': 'Profile',
      'search': 'Search',

      // Games Screen
      'games': 'Games',
      'join_game_to_start': 'Join a game to start playing',
      'no_games_available': 'No Games Available',
      'create_new_game': 'Create a new game to start playing!',
      'friends_games': 'Friends Games',
      'other_games': 'Other Games',
      'no_other_games': 'No other games available right now',
      'loading_games': 'Loading games...',

      // Friends Screen
      'connect_and_play': 'Connect and play together',
      'no_friends_yet': 'No Friends Yet',
      'find_friends_message':
          'Find new friends using the search screen or accept incoming requests.',
      'discover_friends': 'Discover Friends',
      'friend_requests': 'Friend Requests',
      'wants_to_be_friend': 'Wants to be your friend',
      'accept': 'Accept',
      'remove': 'Remove',

      // Search Screen
      'find_friends_and_players': 'Find friends and players',
      'search_by_name_or_email': 'Search by name or email...',
      'find_user_message': 'Find a user by their name or email address',
      'no_matches_found': 'No Matches Found',
      'add_friend': 'Add Friend',
      'remove_friend': 'Remove Friend',
      'cancel_request': 'Cancel Request',
      'pending': 'Pending',
      'online': 'Online',
      'offline': 'Offline',

      // Profile Screen
      'total_games': 'Total Games',
      'won_online': 'Won Online',
      'game_history': 'Game History',
      'offline_games': 'Offline Games',
      'online_games': 'Online Games',
      'games_played': 'games played',
      'won_of': 'won of',
      'played': 'played',
      'score': 'Score',

      // Game Details
      'players': 'Players',
      'questions': 'Questions',
      'join': 'Join',
      'waiting': 'Waiting',
      'in_progress': 'In Progress',

      // Common
      'loading': 'Loading...',
      'error': 'Error',
      'retry': 'Retry',
      'cancel': 'Cancel',
      'ok': 'OK',
      'yes': 'Yes',
      'no': 'No',

      // Search Actions
      'enter_query': 'Please enter some query',
      'add': 'Add',
      'friend': 'Friend',
      'sent': 'Sent',
      'user_already_friend': 'User is already your friend',
      'friend_request_sent_already':
          'You already sent friend request to this user',

      // Language Settings
      'language': 'Language',
      'select_language': 'Select Language',
      'english': 'English',
      'german': 'German',
    },
    'de_DE': {
      // Quiz-Einstellungen
      'num_questions': 'Anzahl der Fragen',
      'category': 'Kategorie',
      'create_quiz': 'Quiz Erstellen',
      'find_quiz': 'Quiz Finden',
      'difficulty': 'Schwierigkeit',

      // Kategorien
      'general_knowledge': 'Allgemeinwissen',
      'books': 'Bücher',
      'films': 'Filme',
      'music': 'Musik',
      'musicals_and_theaters': 'Musicals & Theater',
      'television': 'Fernsehen',
      'video_games': 'Videospiele',
      'board_games': 'Brettspiele',
      'science_and_nature': 'Wissenschaft & Natur',
      'computers': 'Computer',
      'mathematics': 'Mathematik',
      'mythology': 'Mythologie',
      'sports': 'Sport',
      'geography': 'Geographie',
      'history': 'Geschichte',
      'politics': 'Politik',
      'art': 'Kunst',
      'celebrities': 'Prominente',
      'animals': 'Tiere',

      // Schwierigkeit
      'easy': 'Einfach',
      'medium': 'Mittel',
      'hard': 'Schwer',

      // Fehlermeldungen
      'this_error_occurred_while_loading_quiz':
          'Beim Laden des Quiz ist ein Fehler aufgetreten: ',
      'error_loading_quiz': 'Fehler beim Laden des Quiz',

      // Authentifizierung
      'continue_as_guest': 'Als Gast fortfahren',
      'login': 'Anmelden',
      'register': 'Registrieren',
      'sign_out': 'Abmelden',
      'email': 'E-Mail',
      'password': 'Passwort',
      'name': 'Name',
      'email_hint': 'Geben Sie Ihre E-Mail ein',
      'password_hint': 'Geben Sie Ihr Passwort ein',
      'name_hint': 'Geben Sie Ihren Namen ein',
      'already_have_account': 'Haben Sie bereits ein Konto?',
      'dont_have_account': 'Noch kein Konto?',

      // Navigation
      'home': 'Startseite',
      'friends': 'Freunde',
      'profile_tab': 'Profil',
      'search': 'Suchen',

      // Spiele-Bildschirm
      'games': 'Spiele',
      'join_game_to_start': 'Tritt einem Spiel bei, um zu spielen',
      'no_games_available': 'Keine Spiele Verfügbar',
      'create_new_game': 'Erstelle ein neues Spiel, um zu spielen!',
      'friends_games': 'Spiele von Freunden',
      'other_games': 'Andere Spiele',
      'no_other_games': 'Derzeit keine anderen Spiele verfügbar',
      'loading_games': 'Lade Spiele...',

      // Freunde-Bildschirm
      'connect_and_play': 'Verbinde dich und spiele zusammen',
      'no_friends_yet': 'Noch Keine Freunde',
      'find_friends_message':
          'Finde neue Freunde über die Suchfunktion oder akzeptiere eingehende Anfragen.',
      'discover_friends': 'Freunde Entdecken',
      'friend_requests': 'Freundschaftsanfragen',
      'wants_to_be_friend': 'Möchte dein Freund sein',
      'accept': 'Akzeptieren',
      'remove': 'Entfernen',

      // Such-Bildschirm
      'find_friends_and_players': 'Finde Freunde und Spieler',
      'search_by_name_or_email': 'Suche nach Name oder E-Mail...',
      'find_user_message':
          'Finde einen Benutzer über seinen Namen oder seine E-Mail-Adresse',
      'no_matches_found': 'Keine Treffer Gefunden',
      'add_friend': 'Freund Hinzufügen',
      'remove_friend': 'Freund Entfernen',
      'cancel_request': 'Anfrage Abbrechen',
      'pending': 'Ausstehend',
      'online': 'Online',
      'offline': 'Offline',

      // Profil-Bildschirm
      'total_games': 'Spiele Gesamt',
      'won_online': 'Online Gewonnen',
      'game_history': 'Spielverlauf',
      'offline_games': 'Offline-Spiele',
      'online_games': 'Online-Spiele',
      'games_played': 'Spiele gespielt',
      'won_of': 'gewonnen von',
      'played': 'gespielt',
      'score': 'Punktzahl',

      // Spiel-Details
      'players': 'Spieler',
      'questions': 'Fragen',
      'join': 'Beitreten',
      'waiting': 'Warten',
      'in_progress': 'Im Gange',

      // Allgemein
      'loading': 'Lädt...',
      'error': 'Fehler',
      'retry': 'Erneut Versuchen',
      'cancel': 'Abbrechen',
      'ok': 'OK',
      'yes': 'Ja',
      'no': 'Nein',

      // Suchaktionen
      'enter_query': 'Bitte geben Sie eine Suchanfrage ein',
      'add': 'Hinzufügen',
      'friend': 'Freund',
      'sent': 'Gesendet',
      'user_already_friend': 'Benutzer ist bereits Ihr Freund',
      'friend_request_sent_already':
          'Sie haben diesem Benutzer bereits eine Freundschaftsanfrage gesendet',

      // Spracheinstellungen
      'language': 'Sprache',
      'select_language': 'Sprache Auswählen',
      'english': 'Englisch',
      'german': 'Deutsch',
    }
  };

  static List<Map<String, dynamic>> difficultyList = [
    {'difficulty': 'easy'.tr, 'api': 'easy'},
    {'difficulty': 'medium'.tr, 'api': 'medium'},
    {'difficulty': 'hard'.tr, 'api': 'hard'},
  ];

  static List<String> categoryNames = [
    'Random'.tr,
    'general_knowledge'.tr,
    'books'.tr,
    'films'.tr,
    'music'.tr,
    'musicals_and_theaters'.tr,
    'television'.tr,
    'video_games'.tr,
    'board_games'.tr,
    'science_and_nature'.tr,
    'computers'.tr,
    'mathematics'.tr,
    'mythology'.tr,
    'sports'.tr,
    'geography'.tr,
    'history'.tr,
    'politics'.tr,
    'art'.tr,
    'celebrities'.tr,
    'animals'.tr,
  ];

  static List<Map<String, dynamic>> categoryList = [
    {'category': 'Random'.tr, 'api': null},
    {'category': 'general_knowledge'.tr, 'api': 9},
    {'category': 'books'.tr, 'api': 10},
    {'category': 'films'.tr, 'api': 11},
    {'category': 'music'.tr, 'api': 12},
    {'category': 'musicals_and_theaters'.tr, 'api': 13},
    {'category': 'television'.tr, 'api': 14},
    {'category': 'video_games'.tr, 'api': 15},
    {'category': 'board_games'.tr, 'api': 16},
    {'category': 'science_and_nature'.tr, 'api': 17},
    {'category': 'computers'.tr, 'api': 18},
    {'category': 'mathematics'.tr, 'api': 19},
    {'category': 'mythology'.tr, 'api': 20},
    {'category': 'sports'.tr, 'api': 21},
    {'category': 'geography'.tr, 'api': 22},
    {'category': 'history'.tr, 'api': 23},
    {'category': 'politics'.tr, 'api': 24},
    {'category': 'art'.tr, 'api': 25},
    {'category': 'celebrities'.tr, 'api': 26},
    {'category': 'animals'.tr, 'api': 27}
  ];
}
