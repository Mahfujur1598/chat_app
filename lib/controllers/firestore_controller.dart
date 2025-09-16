import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirestoreController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String roomId, String message) async {
    try {
      if (message.trim().isEmpty) return;

      await _firestore
          .collection('rooms')
          .doc(roomId)
          .collection('messages')
          .add({
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  Stream<List<Map<String, dynamic>>> getMessages(String roomId) {
    try {
      return _firestore
          .collection('rooms')
          .doc(roomId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((query) => query.docs.map((doc) => doc.data()).toList());
    } catch (e) {
      print("Error fetching messages: $e");
      return const Stream.empty();
    }
  }
}
