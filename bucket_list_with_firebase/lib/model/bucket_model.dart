import 'package:cloud_firestore/cloud_firestore.dart';

class BucketModel {
  String? documentId;
  late String job;
  late bool isDone;

  BucketModel({
    required this.job,
    required this.isDone,
  });

  BucketModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    documentId = documentSnapshot.id;
    job = documentSnapshot["job"];
    isDone = documentSnapshot["isDone"];
  }
}
