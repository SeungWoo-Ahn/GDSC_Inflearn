import 'package:bucket_list_with_firebase/model/bucket_model.dart';
import 'package:bucket_list_with_firebase/utils/firestore_db.dart';
import 'package:get/get.dart';

class BucketController extends GetxController {
  Rx<List<BucketModel>> bucketList = Rx<List<BucketModel>>([]);
  List<BucketModel> get buckets => bucketList.value;

  @override
  void onReady() {
    bucketList.bindStream(FirestoreDb.todoStream());
  }
}
