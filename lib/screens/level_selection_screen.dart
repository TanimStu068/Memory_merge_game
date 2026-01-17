import 'package:flutter/material.dart';
import '../model/level_model.dart';
import 'game_screen.dart';
import '../model/card_theme.dart';

class LevelSelectionScreen extends StatefulWidget {
  final MemoryCardTheme theme;

  const LevelSelectionScreen({super.key, required this.theme});

  @override
  State<LevelSelectionScreen> createState() => _LevelSelectionScreenState();
}

class _LevelSelectionScreenState extends State<LevelSelectionScreen> {
  int _selectedIndex = -1;

  void _navigateToGame(GameLevel level) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GameScreen(
          theme: widget.theme,
          gridCount: level.crossAxisCount,
          totalCards: level.totalCards,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B223D),
      appBar: AppBar(
        title: const Text(
          'Select Level',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E3A6E),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: levels.length,
          itemBuilder: (context, index) {
            final level = levels[index];
            final isSelected = _selectedIndex == index;

            return GestureDetector(
              onTapDown: (_) => setState(() {
                _selectedIndex = index;
              }),
              onTapUp: (_) {
                setState(() {
                  _selectedIndex = -1;
                });
                _navigateToGame(level);
              },
              onTapCancel: () => setState(() {
                _selectedIndex = -1;
              }),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeOut,
                margin: const EdgeInsets.only(
                  bottom: 16,
                ), // spacing between items
                transform: Matrix4.identity()..scale(isSelected ? 0.95 : 1.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade400.withOpacity(0.9),
                      Colors.blue.shade600.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(6, 6),
                      blurRadius: 12,
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      offset: const Offset(-4, -4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(level.emoji, style: const TextStyle(fontSize: 40)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            level.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black38,
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Grid: ${level.crossAxisCount} x ${level.totalCards ~/ level.crossAxisCount}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
