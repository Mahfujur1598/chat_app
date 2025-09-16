import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/firestore_controller.dart';
import '../../controllers/auth_controller.dart';

class ChatRoomScreen extends StatelessWidget {
  final FirestoreController _firestoreController = Get.put(FirestoreController());
  final AuthController _authController = Get.find();
  final TextEditingController _messageController = TextEditingController();
  final String roomId = "globalRoom";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Global Chat Room"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _authController.signOut(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _firestoreController.getMessages(roomId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                if (snapshot.data!.isEmpty) return Center(child: Text("No messages yet"));

                return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var message = snapshot.data![index];
                    return ListTile(title: Text(message['message'] ?? ''));
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: "Type a message",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _firestoreController.sendMessage(roomId, _messageController.text);
                    _messageController.clear();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
