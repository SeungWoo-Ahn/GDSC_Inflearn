import 'package:diary/diary_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 달력형식
  CalendarFormat calendarFormat = CalendarFormat.month;
  // 선택 날짜
  DateTime selectedDate = DateTime.now();
  // textController 만들기
  TextEditingController createTextController = TextEditingController();
  // textController 업데이트
  TextEditingController updateTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<DiaryService>(
      builder: (context, diaryService, child) {
        List<Diary> diaryList = diaryService.getByDate(selectedDate);
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                TableCalendar(
                  focusedDay: selectedDate,
                  firstDay: DateTime.utc(2022, 01, 01),
                  lastDay: DateTime.utc(2024, 12, 31),
                  calendarFormat: calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      calendarFormat = format;
                    });
                  },
                  calendarStyle: CalendarStyle(
                    todayTextStyle: TextStyle(color: Colors.black),
                    todayDecoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  selectedDayPredicate: (day) {
                    return isSameDay(selectedDate, day);
                  },
                  onDaySelected: (_, focusedDay) {
                    setState(() {
                      selectedDate = focusedDay;
                    });
                  },
                  eventLoader: (day) {
                    return diaryService.getByDate(day);
                  },
                ),
                Divider(
                  height: 1,
                ),
                Expanded(
                  child: diaryList.isEmpty
                      ? EmptyDiary()
                      : ShowDiaryList(diaryList: diaryList),
                ),
              ],
            ),
          ),
          floatingActionButton: CreateDiaryBtn(
            createTextController: createTextController,
            diaryService: diaryService,
            selectedDate: selectedDate,
          ),
        );
      },
    );
  }
}

class CreateDiaryBtn extends StatelessWidget {
  const CreateDiaryBtn({
    Key? key,
    required this.createTextController,
    required this.diaryService,
    required this.selectedDate,
  }) : super(key: key);

  final TextEditingController createTextController;
  final DiaryService diaryService;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.create),
      backgroundColor: Colors.indigo,
      onPressed: () {
        showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              title: Text(
                '일기 작성',
              ),
              content: TextField(
                controller: createTextController,
                autofocus: true,
                cursorColor: Colors.indigo,
                decoration: InputDecoration(
                  hintText: "한 줄 일기를 작성해주세요",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                  ),
                ),
                onSubmitted: (value) {
                  createDiary(diaryService, createTextController, selectedDate);
                  Navigator.pop(context);
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "취소",
                    style: TextStyle(color: Colors.indigo),
                  ),
                ),
                TextButton(
                  onPressed: (() {
                    createDiary(
                        diaryService, createTextController, selectedDate);
                    Navigator.pop(context);
                  }),
                  child: Text(
                    "작성",
                    style: TextStyle(color: Colors.indigo),
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}

void createDiary(DiaryService diaryService, TextEditingController controller,
    DateTime selectedDate) {
  String newText = controller.text.trim();
  if (newText.isNotEmpty) {
    diaryService.create(newText, selectedDate);
    controller.text = "";
  }
}

class ShowDiaryList extends StatelessWidget {
  const ShowDiaryList({
    Key? key,
    required this.diaryList,
  }) : super(key: key);

  final List<Diary> diaryList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: diaryList.length,
      itemBuilder: ((context, index) {
        Diary diary = diaryList[index];
        return ListTile(
          title: Text(
            diary.text,
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
          trailing: Text(
            DateFormat('kk:mm').format(diary.createdAt),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          onTap: () {},
          onLongPress: () {},
        );
      }),
      separatorBuilder: ((context, index) {
        return Divider(
          height: 1,
        );
      }),
    );
  }
}

class EmptyDiary extends StatelessWidget {
  const EmptyDiary({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('일기가 없어요'),
    );
  }
}
