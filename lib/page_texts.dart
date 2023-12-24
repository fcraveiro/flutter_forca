class WelcomePageTexts {
  String title = "Seja bem vindo ao game \ndo Professor Kenny!";
  String subtitle = "Uma forma interativa \ne divertida de aprender =)";
  String startButton = "Quero Jogar";
}

class LevelsPageTexts {
  String menuTitle = "Selecione o nível desejado";
  String letsPlay = "Vamos começar o jogo?";
  String welcomeMessage(String username) => "Hello, $username!";
  String modulesQuantity(int modules) => "$modules módulos";
  String totalPoints(int points) => "$points pontos";
}

class CategoryPageTexts {
  String totalPoints(int points) => "$points pontos";
}

class SubcategoryPageTexts {
  String totalPoints(int points) => "$points pontos";
}

class GamesFlowPageTexts {
  String abortTitle = "Você deseja sair do jogo?";
  String abortDescription = 'Ao sair você encerrará a partida com a sua pontuação atual.\n'
      'Você poderá recomeçar uma nova partida para superar sua pontuação.';
  String abortCancelButton = "Continuar";
  String abortConfirmButton = "Sair";

  String verifyButton = "Verificar";
  String resumeButton = "Continuar";
  String jumpGameButton = "Pular";
  String traductionButton = "Tradução";

  String tipTitle = "Dica do Professor Kenny!";
  String tipResumeButton = "Continuar";
}

class GameWordsAndImagesPageTexts {
  String title = "Arraste as palavras para as imagens correspondentes";
}

class GameSearchWordsTexts {
  String title = "Encontre 6 palavras escondidas no painel";
}

class PageTexts {
  static WelcomePageTexts get welcome => WelcomePageTexts();
  static LevelsPageTexts get levels => LevelsPageTexts();
  static CategoryPageTexts get categories => CategoryPageTexts();
  static SubcategoryPageTexts get subcategories => SubcategoryPageTexts();
  static GamesFlowPageTexts get gameflow => GamesFlowPageTexts();
  static GameWordsAndImagesPageTexts get wordsAndImages => GameWordsAndImagesPageTexts();
  static GameSearchWordsTexts get gameSearchWords => GameSearchWordsTexts();
}
