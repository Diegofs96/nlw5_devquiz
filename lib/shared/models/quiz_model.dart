import 'dart:convert';

import 'package:DevQuiz/shared/models/question_model.dart';

//Criando um neum
enum Level { facil, medico, dificil, perito }

@override
//Extensão para fazer a conversão do Enum
extension LevelStringExtension on String {
  Level get parse => {
        "facil": Level.facil,
        "medico": Level.medico,
        "dificil": Level.dificil,
        "perito": Level.perito
      }[this]!;
}

//Extensão para fazer a conversão do Enum
extension LevelExt on Level {
  String get parse => {
        Level.facil: "facil",
        Level.medico: "medico",
        Level.dificil: "dificil",
        Level.perito: "perito"
      }[this]!;
}

class QuizModel {
  final String title;
  final List<QuestionModel> questions;
  final int questionAwnserd;
  final String imagem;
  final Level level;

  QuizModel({
    required this.title,
    required this.questions,
    this.questionAwnserd = 0,
    required this.imagem,
    required this.level,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'questions': questions.map((x) => x.toMap()).toList(),
      'questionAwnserd': questionAwnserd,
      'imagem': imagem,
      'level': level.parse,
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      title: map['title'],
      questions: List<QuestionModel>.from(
          map['questions'].map((x) => QuestionModel.fromMap(x))),
      questionAwnserd: map['questionAwnserd'],
      imagem: map['imagem'],
      level: map['level'].toString().parse,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizModel.fromJson(String source) =>
      QuizModel.fromMap(json.decode(source));
}
