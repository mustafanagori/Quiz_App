class Question {
  final String questionText;
  final List<Answer> answerList;

  Question(this.questionText, this.answerList);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

List<Question> getQuestions() {
  List<Question> list = [];

  list.add(Question("Who is the owner of Flutter?", [
    Answer("Nokia", false),
    Answer("Microsoft", false),
    Answer("Apple", false),
    Answer("Google", true),
  ]));

  list.add(Question("Which of the following is true regarding Flutter?", [
    Answer("Flutter is a UI toolkit", false),
    Answer("Flutter is free and open-source", false),
    Answer(" All of the above", true),
  ]));

  list.add(Question("Flutter is not a language; it is an SDK. ", [
    Answer("TRUE", true),
    Answer(" FALSE", false),
  ]));

  list.add(Question("The first alpha version of Flutter was released in ?", [
    Answer("2016", false),
    Answer("2017", true),
    Answer("2018", false),
    Answer("2019", false),
  ]));

  list.add(Question("The examples of the Stateless widget are?", [
    Answer("Text", false),
    Answer("Row", false),
    Answer("Column", false),
    Answer(" All of the above", true),
  ]));

  list.add(Question("Which of the following are the advantages of Flutter?", [
    Answer("Cross-platform Development", false),
    Answer("Faster Development", false),
    Answer("Minimal code", false),
    Answer("All of the above", true),
  ]));

  return list;
}
