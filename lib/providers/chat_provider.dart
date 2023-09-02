import '../exports.dart';

class ChatProvider with ChangeNotifier {
  Map<String, String> _status = {};
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  Map<String, String> get status => _status;

  static final _chatCollection = FirebaseFirestore.instance.collection('chats');

  Future<String?> initialize(Chat chat) async {
    _isLoading = true;
    notifyListeners();

    String? chatId;

    try {
      QuerySnapshot findChat = await _chatCollection
          .where('propertyID', isEqualTo: chat.propertyID)
          .get();

      if (findChat.docs.first.exists) {
        chatId = findChat.docs.first.id;
      } else {
        await _chatCollection.add(chat.toMap()).then(
          (value) {
            _chatCollection.doc(value.id).update({'id': value.id});
            chatId = value.id;
            _status = {'status': 'success', 'message': 'Successfully Created!'};
          },
        );
      }
    } on FirebaseException catch (e) {
      _status = {'status': 'error', 'message': e.message ?? ''};
    } catch (e) {
      _status = {'status': 'error', 'message': e.toString()};
    }

    _isLoading = false;
    notifyListeners();

    return chatId;
  }

  Future<void> update(Chat chat) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _chatCollection.doc(chat.id).update(chat.toMap()).then(
        (value) {
          _status = {'status': 'success', 'message': 'Successfully Created!'};
        },
      );
    } on FirebaseException catch (e) {
      _status = {'status': 'error', 'message': e.message ?? ''};
    } catch (e) {
      _status = {'status': 'error', 'message': e.toString()};
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<QuerySnapshot> viewChats(String userID) {
    return _chatCollection.where('tenantID', isEqualTo: userID).get();
  }

  Stream<DocumentSnapshot> streamChat(String chatId) {
    return _chatCollection.doc(chatId).snapshots();
  }
}
