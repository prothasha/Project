
import 'dart:async';
import 'package:flutter/material.dart';

class StudyTimerPage extends StatefulWidget {
  const StudyTimerPage({super.key});

  @override
  State<StudyTimerPage> createState() => _StudyTimerPageState();
}

class _StudyTimerPageState extends State<StudyTimerPage> {
  static const Color burgundy = Color(0xFF702D45);
  static const Color rosePink = Color(0xFFB85C75);
  static const Color blush = Color(0xFFF8E9ED);
  static const Color ivory = Color(0xFFFFFDF8);
  static const Color gold = Color(0xFFE5B65C);
  static const Color mutedText = Color(0xFF7E5965);

  Timer? timer;

  String selectedMode = 'Study';
  int remainingSeconds = 25 * 60;
  bool isRunning = false;

  int get selectedDuration {
    if (selectedMode == 'Study') {
      return 25 * 60;
    } else if (selectedMode == 'Short Break') {
      return 5 * 60;
    } else {
      return 15 * 60;
    }
  }

  String get formattedTime {
    int minutes = remainingSeconds ~/ 60;
    int seconds = remainingSeconds % 60;

    String minuteText = minutes.toString().padLeft(2, '0');
    String secondText = seconds.toString().padLeft(2, '0');

    return '$minuteText:$secondText';
  }

  void selectMode(String mode) {
    timer?.cancel();

    setState(() {
      selectedMode = mode;
      remainingSeconds = selectedDuration;
      isRunning = false;
    });
  }

  void startTimer() {
    if (isRunning || remainingSeconds == 0) {
      return;
    }

    setState(() {
      isRunning = true;
    });

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer currentTimer) {
        if (remainingSeconds > 0) {
          setState(() {
            remainingSeconds--;
          });
        }

        if (remainingSeconds == 0) {
          currentTimer.cancel();
          timer = null;

          setState(() {
            isRunning = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$selectedMode session completed!'),
              backgroundColor: burgundy,
            ),
          );
        }
      },
    );
  }

  void pauseTimer() {
    timer?.cancel();
    timer = null;

    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    timer?.cancel();
    timer = null;

    setState(() {
      remainingSeconds = selectedDuration;
      isRunning = false;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget modeButton(String mode) {
    bool selected = selectedMode == mode;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectMode(mode);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 13,
            horizontal: 5,
          ),
          decoration: BoxDecoration(
            color: selected ? burgundy : ivory,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: burgundy),
          ),
          child: Text(
            mode,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? ivory : burgundy,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress =
        1 - (remainingSeconds / selectedDuration);

    return Scaffold(
      backgroundColor: blush,
      appBar: AppBar(
        title: const Text(
          'Study Timer',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: burgundy,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: burgundy,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.timer_rounded,
                    color: gold,
                    size: 45,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Focus on Your Goals',
                    style: TextStyle(
                      color: ivory,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Work with focus, take breaks and make every study session productive.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Choose Your Session',
              style: TextStyle(
                color: burgundy,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                modeButton('Study'),
                const SizedBox(width: 8),
                modeButton('Short Break'),
                const SizedBox(width: 8),
                modeButton('Long Break'),
              ],
            ),

            const SizedBox(height: 32),

            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: ivory,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: const Color(0xFFE8C9D2),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    selectedMode,
                    style: const TextStyle(
                      color: mutedText,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    height: 210,
                    width: 210,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 210,
                          width: 210,
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 10,
                            backgroundColor: blush,
                            valueColor:
                                const AlwaysStoppedAnimation<Color>(
                              rosePink,
                            ),
                          ),
                        ),

                        Text(
                          formattedTime,
                          style: const TextStyle(
                            color: burgundy,
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  Text(
                    isRunning ? 'Stay Focused!' : 'Ready to Begin?',
                    style: const TextStyle(
                      color: mutedText,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: isRunning
                              ? pauseTimer
                              : startTimer,
                          icon: Icon(
                            isRunning
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                          ),
                          label: Text(
                            isRunning ? 'Pause' : 'Start',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: burgundy,
                            foregroundColor: ivory,
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: resetTimer,
                          icon: const Icon(
                            Icons.refresh_rounded,
                          ),
                          label: const Text('Reset'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: burgundy,
                            side: const BorderSide(
                              color: burgundy,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: ivory,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pomodoro Study Method',
                    style: TextStyle(
                      color: burgundy,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 14),
                  Text(
                    '25 minutes — Focused study',
                    style: TextStyle(color: mutedText),
                  ),
                  SizedBox(height: 9),
                  Text(
                    '5 minutes — Short break',
                    style: TextStyle(color: mutedText),
                  ),
                  SizedBox(height: 9),
                  Text(
                    '15 minutes — Long break',
                    style: TextStyle(color: mutedText),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
