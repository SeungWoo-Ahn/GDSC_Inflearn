import 'package:bucket_list_with_firebase/model/bucket_model.dart';
import 'package:bucket_list_with_firebase/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDb {
  // datasnapShot 가져오기
  static Stream<List<BucketModel>> todoStream() {
    return firebaseFirestore
        .collection('user')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('buckets')
        .snapshots()
        .map((QuerySnapshot query) {
      List<BucketModel> buckets = [];
      for (var bucket in query.docs) {
        final bucketModel =
            BucketModel.fromDocumentSnapshot(documentSnapshot: bucket);
        buckets.add(bucketModel);
      }
      return buckets;
    });
  }

  // 버킷 만들기
  static create(BucketModel bucketModel) async {
    await firebaseFirestore
        .collection('user')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('buckets')
        .add({
      'job': bucketModel.job,
      'isDone': false,
    });
  }

  // 상태 업데이트
  static updateStatus(bool isDone, documentId) {
    firebaseFirestore
        .collection('user')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('buckets')
        .doc(documentId)
        .update({
      'isDone': isDone,
    });
  }

  // 버킷 삭제하기
  static deleteBucket(String documentId) {
    firebaseFirestore
        .collection('user')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('buckets')
        .doc(documentId)
        .delete();
  }
}
