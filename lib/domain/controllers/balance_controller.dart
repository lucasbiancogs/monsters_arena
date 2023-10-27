enum GameDificulty {
  easy,
  medium,
  hard,
}

class BalanceController {
  BalanceController({this.dificulty = GameDificulty.easy});

  final GameDificulty dificulty;

  double get playerSpeed {
    switch (dificulty) {
      case GameDificulty.easy:
        return 100;
      case GameDificulty.medium:
        return 150;
      case GameDificulty.hard:
        return 200;
    }
  }
}
