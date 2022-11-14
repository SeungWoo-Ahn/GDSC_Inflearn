import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class Diary {
  String text; // 내용
  DateTime createdAt; // 작성 시간

  Diary({
    required this.text,
    required this.createdAt,
  });

  // Diary 를 Map 변환
  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "createdAt": createdAt.toString(),
    };
  }

  // Map 을 Diary로 변환
  factory Diary.fromJson(Map<String, dynamic> jsonMap) {
    return Diary(
      text: jsonMap['text'],
      createdAt: DateTime.parse(jsonMap['createdAt']),
    );
  }
}

class DiaryService extends ChangeNotifier {
  //생성자
  DiaryService(this.prefs) {
    //호출될때 String -> Map -> Diary 로 변환
    List<String> strintDiaryList = prefs.getStringList("diaryList") ?? [];
    for (String stringDiary in strintDiaryList) {
      Map<String, dynamic> jsonMap = jsonDecode(stringDiary);

      Diary diary = Diary.fromJson(jsonMap);
      diaryList.add(diary);
    }
  }

  //SharedPref 인스턴스
  SharedPreferences prefs;

  /// Diary 목록
  List<Diary> diaryList = [];

  /// 특정 날짜의 diary 조회
  List<Diary> getByDate(DateTime date) {
    return diaryList
        .where((diary) => isSameDay(date, diary.createdAt))
        .toList();
  }

  /// Diary 작성
  void create(String text, DateTime selectedDate) {
    DateTime now = DateTime.now();
    DateTime createdAt = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      now.hour,
      now.minute,
      now.second,
    );

    diaryList.add(Diary(text: text, createdAt: createdAt));
    notifyListeners();

    _saveDiaryList();
  }

  /// Diary 수정
  void update(DateTime createdAt, String newContent) {
    Diary diary;
    for (Diary eachDiary in diaryList) {
      if (eachDiary.createdAt == createdAt) {
        diary = eachDiary;
        diary.text = newContent;
        break;
      }
    }
    notifyListeners();

    _saveDiaryList();
  }

  /// Diary 삭제
  void delete(DateTime createdAt) {
    for (Diary diary in diaryList) {
      if (diary.createdAt == createdAt) {
        diaryList.remove(diary);
        break;
      }
    }
    notifyListeners();

    _saveDiaryList();
  }

  // 변경된 Diary SharedPref 로 저장
  void _saveDiaryList() {
    //json 을 사용하기 위해 Diary -> Map -> String 순으로 변환
    List<String> stringDiaryList = [];
    for (Diary diary in diaryList) {
      Map<String, dynamic> jsonMap = diary.toJson();
      String stringDiary = jsonEncode(jsonMap);
      stringDiaryList.add(stringDiary);
    }
    prefs.setStringList("diaryList", stringDiaryList);
  }
}
