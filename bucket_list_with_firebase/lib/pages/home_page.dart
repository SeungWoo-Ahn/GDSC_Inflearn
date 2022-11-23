import 'package:bucket_list_with_firebase/controller/bucket_controller.dart';
import 'package:bucket_list_with_firebase/model/bucket_model.dart';
import 'package:bucket_list_with_firebase/utils/constants.dart';
import 'package:bucket_list_with_firebase/utils/firestore_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      authController.logout();

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
    final TextEditingController jobController = TextEditingController();

    // 버킷 추가하기
    void addBucket() async {
      final bucketModel = BucketModel(
        job: jobController.text.trim(),
        isDone: false,
      );

      if (jobController.text.isNotEmpty) {
        await FirestoreDb.create(bucketModel);
        jobController.clear();
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
            onPressed: () async {
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
    return GetX<BucketController>(
      init: Get.put<BucketController>(BucketController()),
      builder: (BucketController controller) {
        return Expanded(
          child: controller.buckets.isEmpty
              ? _EmptyBucketView()
              : ListView.builder(
                  itemCount: controller.buckets.length,
                  itemBuilder: (context, index) {
                    final bucketModel = controller.buckets[index];
                    return _BuckListItem(
                      model: bucketModel,
                    );
                  },
                ),
        );
      },
    );
  }
}

//버킷 리스트 각 아이템
class _BuckListItem extends StatelessWidget {
  const _BuckListItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  final BucketModel model;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        model.job,
        style: TextStyle(
          fontSize: 24,
          color: model.isDone ? Colors.grey : Colors.black,
          decoration:
              model.isDone ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      // 삭제 아이콘 버튼
      trailing: IconButton(
        icon: Icon(CupertinoIcons.delete),
        onPressed: () {
          // 삭제 버튼 클릭시
          FirestoreDb.deleteBucket(model.documentId!);
        },
      ),
      onTap: () {
        // 아이템 클릭하여 isDone 업데이트
        FirestoreDb.updateStatus(!model.isDone, model.documentId);
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
