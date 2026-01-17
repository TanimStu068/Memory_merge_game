import 'package:flutter/material.dart';
import 'package:memory_match_game/model/card_theme.dart';
import 'package:memory_match_game/screens/level_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _pressedIndex = -1;
  String searchQuery = '';

  // Slightly lighter card colors for better contrast
  final List<Color> cardColors = [
    const Color(0xFFE69145), // lighter orange
    const Color(0xFF2ECC71), // lighter green
    const Color(0xFF3498DB), // lighter blue
  ];

  void _navigateToLevelSelectionScreen(
    BuildContext context,
    MemoryCardTheme theme,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LevelSelectionScreen(theme: theme),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 11, 34, 61), // dark background
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Title
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 2),
              builder: (context, double value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: 0.8 + 0.2 * value,
                    child: child,
                  ),
                );
              },
              child: const Text(
                'Select Theme',
                style: TextStyle(
                  fontSize: 32,
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
            ),
            const SizedBox(height: 20), // small spacing
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Theme...',
                  hintStyle: TextStyle(color: Colors.white70),
                  prefixIcon: Icon(Icons.search, color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
              ),
            ),
            const SizedBox(height: 20), // spacing before the list
            // Card theme options
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Filtered themes
                    Builder(
                      builder: (context) {
                        final filteredThemes = availableThemes
                            .where(
                              (theme) => theme.name.toLowerCase().contains(
                                searchQuery,
                              ),
                            )
                            .toList();

                        return Column(
                          children: List.generate(filteredThemes.length, (
                            index,
                          ) {
                            final theme = filteredThemes[index];
                            final isPressed = _pressedIndex == index;

                            return GestureDetector(
                              onTapDown: (_) =>
                                  setState(() => _pressedIndex = index),
                              onTapUp: (_) async {
                                await Future.delayed(
                                  const Duration(milliseconds: 120),
                                );
                                setState(() => _pressedIndex = -1);
                                _navigateToLevelSelectionScreen(context, theme);
                              },
                              onTapCancel: () =>
                                  setState(() => _pressedIndex = -1),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                curve: Curves.easeOut,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                width: double.infinity,
                                height: 130,
                                transform: Matrix4.identity()
                                  ..scale(isPressed ? 0.95 : 1.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      cardColors[index % cardColors.length]
                                          .withOpacity(0.9),
                                      cardColors[index % cardColors.length]
                                          .withOpacity(0.7),
                                      Colors.white.withOpacity(0.1),
                                    ],
                                  ),
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
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      height: 30,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.white.withOpacity(0.25),
                                              Colors.transparent,
                                            ],
                                          ),
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                top: Radius.circular(20),
                                              ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 24,
                                          ),
                                          child: Text(
                                            theme.name,
                                            style: const TextStyle(
                                              fontSize: 26,
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
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 24,
                                          ),
                                          child: Text(
                                            theme.cards.take(3).join(' '),
                                            style: const TextStyle(
                                              fontSize: 34,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
