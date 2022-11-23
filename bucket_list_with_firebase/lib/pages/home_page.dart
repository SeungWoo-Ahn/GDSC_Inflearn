import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/auth_service.dart';
import '../service/bucket_service.dart';
import 'login_page.dart';

/// 홈페이지
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _BucketAppBar(),
      body: _BucketBody(),
    );
  }
}

class _BucketAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    // 로그아웃
    void logout() {
      context.read<AuthService>().signOut();

      // 로그인 페이지로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }

    return AppBar(
      title: Text("버킷 리스트"),
      actions: [
        TextButton(
          child: Text(
            "로그아웃",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            logout();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _BucketBody extends StatelessWidget {
  _BucketBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HeaderInputArea(),
        Divider(height: 1),
        _BucketList(),
      ],
    );
  }
}

/// 상단 입력창
class _HeaderInputArea extends StatelessWidget {
  const _HeaderInputArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bucketService = context.watch<BucketService>();
    final authService = context.read<AuthService>();
    User user = authService.currentUser()!; // ! 는 null을 벗겨줌

    final TextEditingController jobController = TextEditingController();

    // 버킷 추가하기
    void addBucket() {
      if (jobController.text.isNotEmpty) {
        bucketService.create(jobController.text, user.uid);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          /// 텍스트 입력창
          Expanded(
            child: TextField(
              controller: jobController,
              decoration: InputDecoration(
                hintText: "하고 싶은 일을 입력해주세요.",
              ),
            ),
          ),

          /// 추가 버튼
          ElevatedButton(
            child: Icon(Icons.add),
            onPressed: () {
              addBucket();
            },
          ),
        ],
      ),
    );
  }
}

/// 버킷 리스트
class _BucketList extends StatelessWidget {
  const _BucketList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bucketService = context.watch<BucketService>();
    final authService = context.read<AuthService>();
    User user = authService.currentUser()!; // ! 는 null을 벗겨줌

    return Expanded(
      child: FutureBuilder<QuerySnapshot>(
          future: bucketService.read(user.uid),
          builder: (context, snapshot) {
            final documents =
                snapshot.data?.docs ?? []; // ?. data가 있을때만 실행, 없으면 빈 배열 반환
            return documents.isEmpty
                ? _EmptyBucketView()
                : ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final doc = documents[index];
                      String job = doc.get("job");
                      bool isDone = doc.get("isDone");
                      return _BuckListItem(
                          job: job,
                          isDone: isDone,
                          bucketService: bucketService,
                          doc: doc);
                    },
                  );
          }),
    );
  }
}

//버킷 리스트 각 아이템
class _BuckListItem extends StatelessWidget {
  const _BuckListItem({
    Key? key,
    required this.job,
    required this.isDone,
    required this.bucketService,
    required this.doc,
  }) : super(key: key);

  final String job;
  final bool isDone;
  final BucketService bucketService;
  final QueryDocumentSnapshot<Object?> doc;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        job,
        style: TextStyle(
          fontSize: 24,
          color: isDone ? Colors.grey : Colors.black,
          decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      // 삭제 아이콘 버튼
      trailing: IconButton(
        icon: Icon(CupertinoIcons.delete),
        onPressed: () {
          // 삭제 버튼 클릭시
          bucketService.delete(doc.id);
        },
      ),
      onTap: () {
        // 아이템 클릭하여 isDone 업데이트
        bucketService.update(doc.id, !isDone);
      },
    );
  }
}

// 버킷이 비어있을 때 뷰
class _EmptyBucketView extends StatelessWidget {
  const _EmptyBucketView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("버킷 리스트를 작성해주세요"));
  }
}
