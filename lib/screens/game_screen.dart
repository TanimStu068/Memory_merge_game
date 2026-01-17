import 'dart:async';
import 'package:flutter/material.dart';
import 'package:memory_match_game/widgets/win_dialog.dart';
import '../constants/colors.dart';
import '../widgets/card_widget.dart';
import '../model/card_theme.dart';
import 'package:audioplayers/audioplayers.dart';

class GameScreen extends StatefulWidget {
  final MemoryCardTheme theme;
  final int gridCount;
  final int totalCards;

  const GameScreen({
    super.key,
    required this.theme,
    required this.gridCount,
    required this.totalCards,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<String> cardValues;
  late List<bool> cardFlipped;
  List<int> selectedIndex = [];
  int moves = 0;
  Timer? timer;
  int seconds = 0;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initGame();
    _startTimer();
  }

  Future<void> _playWinSound() async {
    await _audioPlayer.play(AssetSource('sounds/result_music.mp3'));
  }

  void _initGame() {
    final neededPairs = widget.totalCards ~/ 2;
    final cards = widget.theme.cards.take(neededPairs).toList();
    // Duplicate the cards to make pairs
    cardValues = [...cards, ...cards];
    cardValues.shuffle();
    cardFlipped = List.generate(cardValues.length, (index) => false);
    selectedIndex.clear();
    moves = 0;
    seconds = 0;
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => seconds++);
    });
  }

  void _stopTimer() {
    timer?.cancel();
  }

  void _resetGame() {
    setState(() {
      _initGame();
      _stopTimer();
      _startTimer();
    });
  }

  void _onCardTap(int index) {
    if (cardFlipped[index] || selectedIndex.length == 2) return;

    setState(() {
      cardFlipped[index] = true;
      selectedIndex.add(index);

      if (selectedIndex.length == 2) {
        moves++;

        // Not a match
        if (cardValues[selectedIndex[0]] != cardValues[selectedIndex[1]]) {
          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              cardFlipped[selectedIndex[0]] = false;
              cardFlipped[selectedIndex[1]] = false;
              selectedIndex.clear();
            });
          });
        } else {
          // Match found
          selectedIndex.clear();

          // ✅ Check game finish
          if (isGameFinished) {
            _stopTimer();

            _playWinSound();
            Future.delayed(const Duration(milliseconds: 300), () {
              _showWinDialog();
            });
          }
        }
      }
    });
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WinDialog(
        moves: moves,
        seconds: seconds,
        onRestart: () {
          Navigator.pop(context);
          _resetGame();
        },
        onHome: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
    );
  }

  bool get isGameFinished => cardFlipped.every((flipped) => flipped);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: MainColor.primaryColor,
        title: Text(
          'Theme: ${widget.theme.name} | Moves: $moves | Time: ${seconds}s',
          style: const TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.theme.backgroundAsset),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              shrinkWrap: true, // take only the height needed
              physics:
                  const NeverScrollableScrollPhysics(), // scrolling handled by parent
              itemCount: cardValues.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.gridCount,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1, // square cards
              ),
              itemBuilder: (context, index) {
                return CardWidget(
                  value: cardValues[index],
                  isFlipped: cardFlipped[index],
                  onTap: () => _onCardTap(index),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _resetGame,
        backgroundColor: MainColor.accentColor,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    timer?.cancel();
    super.dispose();
  }
}
