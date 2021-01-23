import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_edmt_quiz_app/const/const.dart';
import 'package:flutter_edmt_quiz_app/database/db_helper.dart';
import 'package:flutter_edmt_quiz_app/database/question_provider.dart';
import 'package:flutter_edmt_quiz_app/model/user_answer_model.dart';
import 'package:flutter_edmt_quiz_app/state/state_manager.dart';
import 'package:flutter_edmt_quiz_app/widgets/count_down.dart';
import 'package:flutter_edmt_quiz_app/widgets/question_body.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MyQuestionDetailPage extends StatefulWidget {
  MyQuestionDetailPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => _MyQuestionDetailPageState();
}

class _MyQuestionDetailPageState extends State<MyQuestionDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      var currentQuestion = watch(userViewQuestionState).state;

      return WillPopScope(
          child: Scaffold(
              appBar: AppBar(
                title: Text('${currentQuestion.questionId} (in database)'),
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back),
                ),
              ),
              body: Container(
                  color: Colors.white10,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            AutoSizeText('${currentQuestion.questionText}'),
                            // Question
                            Visibility(
                                visible: (currentQuestion.isImageQuestion == null ||
                                    currentQuestion.isImageQuestion == 0
                                    ? false
                                    : true),
                                child: Container(
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height / 15 * 3,
                                  child: currentQuestion.isImageQuestion == 0
                                      ? Container()
                                      : Image.network(
                                    '${currentQuestion.questionImage}',
                                    fit: BoxFit.fill,
                                  ),
                                )),
                            // if question is image, show image
                            Expanded(
                                child: ListTile(
                                  title: AutoSizeText(
                                    '${currentQuestion.answerA}',
                                    style: TextStyle(
                                        color: currentQuestion.correctAnswer ==
                                            'A'
                                            ? Colors.red
                                            : Colors.grey),
                                  ),
                                  leading: Radio(
                                      value: 'A',
                                      groupValue: currentQuestion.correctAnswer,
                                      onChanged: null),
                                )),
                            // answer A
                            Expanded(
                                child: ListTile(
                                  title: AutoSizeText(
                                    '${currentQuestion.answerB}',
                                    style: TextStyle(
                                        color: currentQuestion.correctAnswer ==
                                            'B'
                                            ? Colors.red
                                            : Colors.grey),
                                  ),
                                  leading: Radio(
                                      value: 'B',
                                      groupValue: currentQuestion.correctAnswer,
                                      onChanged: null),
                                )),
                            // answer B
                            Expanded(
                                child: ListTile(
                                  title: AutoSizeText(
                                    '${currentQuestion.answerC}',
                                    style: TextStyle(
                                        color: currentQuestion.correctAnswer ==
                                            'C'
                                            ? Colors.red
                                            : Colors.grey),
                                  ),
                                  leading: Radio(
                                    value: 'C',
                                    groupValue: currentQuestion.correctAnswer,
                                    onChanged: null,
                                  ),
                                )),
                            // answer C
                            Expanded(
                                child: ListTile(
                                  title: AutoSizeText(
                                    '${currentQuestion.answerD}',
                                    style: TextStyle(
                                        color: currentQuestion.correctAnswer ==
                                            'D'
                                            ? Colors.red
                                            : Colors.grey),
                                  ),
                                  leading: Radio(
                                    value: 'D',
                                    groupValue: currentQuestion.correctAnswer,
                                    onChanged: null,
                                  ),
                                ))
                            // answer D
                          ],
                        ),
                      ),
                    ]
                    ,
                  )

              )),
          onWillPop: () async {
            Navigator.pop(context);
            return true;
          });
    });
    }
  }
