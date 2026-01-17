class MemoryCardTheme {
  final String name;
  final List<String> cards;
  final String backgroundAsset;

  MemoryCardTheme({
    required this.name,
    required this.cards,
    required this.backgroundAsset,
  });
}

final List<MemoryCardTheme> availableThemes = [
  MemoryCardTheme(
    name: 'Fruits',
    cards: ['🍎', '🍌', '🍇', '🍉', '🍓', '🥭', '🍍', '🍑'],
    backgroundAsset: 'assets/images/fruits.jpg',
  ),
  MemoryCardTheme(
    name: 'Animals',
    cards: ['🐶', '🐱', '🦁', '🐮', '🐸', '🐵', '🐧', '🐤'],
    backgroundAsset: 'assets/images/animals.png',
  ),
  MemoryCardTheme(
    name: 'Sports',
    cards: ['⚽', '🏀', '🏈', '🎾', '🏐', '🏉', '🎱', '🥎'],
    backgroundAsset: 'assets/images/sports.jpg',
  ),
  MemoryCardTheme(
    name: 'Fun Faces',
    cards: ['🤣', '😎', '😍', '🥳', '😢', '😡', '😱', '🤔'],
    backgroundAsset: 'assets/images/fun_image.png',
  ),
  MemoryCardTheme(
    name: 'Nature',
    cards: ['🌲', '🌸', '🌵', '🌻', '🍁', '🌴', '🌾', '🌿'],
    backgroundAsset: 'assets/images/nature.jpg',
  ),
  MemoryCardTheme(
    name: 'Transport',
    cards: ['🚗', '🚌', '🚀', '🛵', '🚲', '🚤', '✈️', '🚁'],
    backgroundAsset: 'assets/images/transport.jpg',
  ),
  MemoryCardTheme(
    name: 'Food',
    cards: ['🍕', '🍔', '🍟', '🌭', '🍿', '🍩', '🍪', '🥪'],
    backgroundAsset: 'assets/images/food.png',
  ),
  MemoryCardTheme(
    name: 'Music',
    cards: ['🎸', '🎹', '🥁', '🎷', '🎺', '🎻', '🎤', '🎧'],
    backgroundAsset: 'assets/images/music.jpg',
  ),
  MemoryCardTheme(
    name: 'Weather',
    cards: ['☀️', '🌙', '⛈', '🌈', '❄️', '🌪', '🌊', '🌫'],
    backgroundAsset: 'assets/images/weather.jpg',
  ),
  MemoryCardTheme(
    name: 'Space',
    cards: ['🪐', '🌑', '🌕', '🌟', '🌠', '🚀', '👽', '🛸'],
    backgroundAsset: 'assets/images/space.jpg',
  ),
];
