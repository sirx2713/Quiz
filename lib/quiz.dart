import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  // Questions list
  List<Map<String, dynamic>> questions = [
    {
      'question': 'This is a quiz game',
      'answer': true,
    },
    {
      'question': 'Flutter is a mobile development framework',
      'answer': true,
    },
    {
      'question': 'Dart is developed by Microsoft',
      'answer': false,
    },
    // Add more questions here
  ];

  int currentQuestionIndex = 0;
  int score = 0;
  List<Icon> scoreKeeper = [];
  bool isGameOver = false;

  void checkAnswer(bool userAnswer) {
    if (isGameOver) return;

    bool correctAnswer = questions[currentQuestionIndex]['answer'];
    setState(() {
      if (userAnswer == correctAnswer) {
        scoreKeeper.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
        score++;
      } else {
        scoreKeeper.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }

      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        isGameOver = true;
        showGameOver();
      }
    });
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      scoreKeeper.clear();
      isGameOver = false;
    });
  }

  void showGameOver() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff31511E),
          title: Text(
            'Quiz Complete!',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Your score: $score/${questions.length}',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              child: Text(
                'Play Again',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                resetQuiz();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff181C14),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: Text(
                  questions[currentQuestionIndex]['question'],
                  key: ValueKey<int>(currentQuestionIndex),
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Score: $score/${questions.length}',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 60),
              GestureDetector(
                onTap: () => checkAnswer(true),
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xff31511E),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    "True",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () => checkAnswer(false),
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    "False",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: scoreKeeper,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
