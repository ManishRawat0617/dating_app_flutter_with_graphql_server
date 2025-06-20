import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:dating_app/screens/create_profile/common_widget/dot_indicator.dart';
import 'package:dating_app/screens/create_profile/personality/page/personality_page.dart';
import 'package:flutter/material.dart';

class FullPersonalityQuizScreen extends StatefulWidget {
  const FullPersonalityQuizScreen({super.key});

  @override
  State<FullPersonalityQuizScreen> createState() =>
      _FullPersonalityQuizScreenState();
}

class _FullPersonalityQuizScreenState extends State<FullPersonalityQuizScreen> {
  final List<_QuizQuestion> questions = [
    _QuizQuestion("I prefer spending time...", "E", "I", "At parties",
        "Alone or with a close friend"),
    _QuizQuestion("I tend to trust...", "S", "N", "Facts and reality",
        "Ideas and theories"),
    _QuizQuestion("When making decisions...", "T", "F", "I focus on logic",
        "I consider feelings"),
    _QuizQuestion("I prefer a lifestyle that is...", "J", "P",
        "Organized and planned", "Flexible and spontaneous"),
    _QuizQuestion("I am energized by...", "E", "I", "Being around people",
        "Having alone time"),
    _QuizQuestion("I rely more on...", "S", "N", "Concrete details",
        "Abstract impressions"),
    _QuizQuestion("I believe fairness means...", "T", "F", "Being objective",
        "Being compassionate"),
    _QuizQuestion(
        "My work style is...", "J", "P", "I like structure", "I adapt as I go"),
  ];

  final Map<int, String> selectedAnswers = {};

  String? getPersonalityResult() {
    if (selectedAnswers.length < questions.length) return null;

    Map<String, int> scores = {
      'E': 0,
      'I': 0,
      'S': 0,
      'N': 0,
      'T': 0,
      'F': 0,
      'J': 0,
      'P': 0
    };

    selectedAnswers.forEach((index, type) {
      scores[type] = scores[type]! + 1;
    });
    print(scores);

    return (scores['E']! >= scores['I']! ? 'E' : 'I') +
        (scores['S']! >= scores['N']! ? 'S' : 'N') +
        (scores['T']! >= scores['F']! ? 'T' : 'F') +
        (scores['J']! >= scores['P']! ? 'J' : 'P');
  }

  void _submitQuiz() {
    final result = getPersonalityResult();
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please answer all questions.")),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Your Personality Type"),
          content: Text("You are: $result"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PersonalityPage(
                        personalityType: result,
                      ))),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DotIndicatorWidget(currentIndex: 5, shouldSkip: false),
              const SizedBox(
                height: 30,
              ),
              const TextWidget(
                title: "Personality Quizz",
                textColor: ColorConstants.primary,
                boldness: FontWeight.bold,
                textSize: 24,
              ),
              SizedBox(
                height: 10,
              ),
              ...List.generate(questions.length,
                  (index) => _buildQuestion(index, questions[index])),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitQuiz,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion(int index, _QuizQuestion question) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  offset: Offset(3, 2), color: Colors.pinkAccent, blurRadius: 1)
            ],
            border: Border.all(
              color: ColorConstants.primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question.question,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              RadioListTile<String>(
                title: Text(question.option1),
                activeColor: ColorConstants.primary,
                value: question.type1,
                groupValue: selectedAnswers[index],
                onChanged: (value) =>
                    setState(() => selectedAnswers[index] = value!),
              ),
              RadioListTile<String>(
                title: Text(question.option2),
                activeColor: ColorConstants.primary,
                value: question.type2,
                groupValue: selectedAnswers[index],
                onChanged: (value) =>
                    setState(() => selectedAnswers[index] = value!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuizQuestion {
  final String question;
  final String type1;
  final String type2;
  final String option1;
  final String option2;

  _QuizQuestion(
      this.question, this.type1, this.type2, this.option1, this.option2);
}
