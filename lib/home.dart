import 'package:flutter/material.dart';

import 'question_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Question> questionList = getQuestions();
  int currentQuestionIndex = 0;
  int score = 0;
  Answer? selectedAnswer;
  bool isLoading = false; // Added to track loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 50, 80),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Quiz Apps",
          style: TextStyle(
            letterSpacing: 2,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: questionList != null && questionList.isNotEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Question ${currentQuestionIndex + 1} / ${questionList.length}",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    _questionWidget(),
                    const SizedBox(
                      height: 10,
                    ),
                    _answerList(),
                    const SizedBox(
                      height: 20,
                    ),
                    _nextButton(),
                  ],
                )
              : const Text("List is empty")),
    );
  }

  Widget _questionWidget() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: Colors.deepPurple),
            ),
            child: Text(
              questionList[currentQuestionIndex]?.questionText ??
                  "No question available",
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _answerList() {
    return Column(
      children: questionList[currentQuestionIndex]
          .answerList
          .map((e) => _answerButton(e))
          .toList(),
    );
  }

  Widget _answerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: isSelected ? Colors.orange : Colors.white,
          onPrimary: isSelected ? Colors.white : Colors.black,
        ),
        onPressed: () {
          if (selectedAnswer == null) {
            if (answer.isCorrect) {
              score++;
            }
            setState(() {
              selectedAnswer = answer;
            });
          }
        },
        child: Text(answer.answerText),
      ),
    );
  }

  Widget _nextButton() {
    bool isLastQuestion = currentQuestionIndex == questionList.length - 1;
    if (isLastQuestion) {
      setState(() {
        isLoading = true;
      });
    }
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        child: Text(isLoading ? "Submit" : "Next"),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: Colors.blueAccent,
          onPrimary: Colors.white,
        ),
        onPressed: () {
          setState(() {
            if (isLastQuestion) {
              _showScoreDialog();
            } else {
              selectedAnswer = null;
              currentQuestionIndex++;
            }
          });
        },
      ),
    );
  }

  _showScoreDialog() {
    bool isPassed =
        score >= questionList.length * 0.6; // Corrected the pass threshold
    String title = isPassed ? "Passed" : "Failed";
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "$title | Score is $score",
          style: TextStyle(color: isPassed ? Colors.green : Colors.red),
        ),
        content: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                currentQuestionIndex = 0;
                score = 0;
                selectedAnswer = null;
              });
            },
            child: const Text(
              "Restart Quiz",
              style: TextStyle(fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }
}
