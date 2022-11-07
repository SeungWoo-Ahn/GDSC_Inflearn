import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Diary {
  String text; // 내용
  DateTime createdAt; // 작성 시간

  Diary({
    required this.text,
    required this.createdAt,
  });
}

class DiaryService extends ChangeNotifier {
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
  }
}
