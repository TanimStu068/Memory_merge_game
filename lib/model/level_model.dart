class GameLevel {
  final String name;
  final int crossAxisCount;
  final int totalCards;
  final String emoji;

  const GameLevel({
    required this.name,
    required this.crossAxisCount,
    required this.totalCards,
    required this.emoji,
  });
}

const levels = [
  GameLevel(name: "Easy", crossAxisCount: 3, totalCards: 6, emoji: "🐣"),
  GameLevel(name: "Medium", crossAxisCount: 4, totalCards: 12, emoji: "😊"),
  GameLevel(name: "Pro", crossAxisCount: 4, totalCards: 16, emoji: "🔥"),
];
