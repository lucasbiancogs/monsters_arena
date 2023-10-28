class Sprites {
  static const _spritesRoot = 'sprites';

  // Fish Sprites
  static const String fishIdle = 'fish_idle';
  static const String fishRun = 'fish_run';
  static spritePath(String spriteName) => '$_spritesRoot/$spriteName.png';
  static const List<String> sprites = [
    fishIdle,
    fishRun,
  ];
}
