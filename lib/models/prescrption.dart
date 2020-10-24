import 'package:cloud_firestore/cloud_firestore.dart';

class Prescription {
  String userId;
  String prescriptionId;
  String prescriptionUrl;
  bool isEntered;
  bool isDispatched;
  bool isDelivered;
  bool isLocked;
  String lockedBy;

  Prescription(
      {this.userId,
      this.prescriptionId,
      this.prescriptionUrl,
      this.isEntered,
      this.isDispatched,
      this.isDelivered,
      this.isLocked,
      this.lockedBy});

  factory Prescription.fromDocument(DocumentSnapshot doc) {
    return Prescription(
        userId: doc['userId'],
        prescriptionId: doc['prescriptionId'],
        prescriptionUrl: doc['prescriptionUrl'],
        isEntered: doc['isEntered'],
        isDispatched: doc['isDispatched'],
        isDelivered: doc['isDelivered'],
        isLocked: doc['isLocked'],
        lockedBy: doc['lockedBy']);
  }
}
