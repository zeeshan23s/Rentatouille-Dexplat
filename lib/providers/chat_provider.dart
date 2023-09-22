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

      if (findChat.docs.isNotEmpty) {
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

  Future<void> update(String chatId, Map<String, String> message) async {
    _isLoading = true;
    notifyListeners();

    List<dynamic> chat = [];

    try {
      await _chatCollection.doc(chatId).get().then((value) {
        if (value.data()!.entries.first.value.isNotEmpty) {
          chat = value.data()!.entries.first.value;
        }
      });

      chat.add(message);

      await _chatCollection.doc(chatId).update({'chat': chat}).then(
        (value) {
          _status = {'status': 'success', 'message': 'Successfully Created!'};
        },
      );
    } on FirebaseException catch (e) {
      debugPrint(message.toString());
      _status = {'status': 'error', 'message': e.message ?? ''};
    } catch (e) {
      debugPrint(message.toString());
      _status = {'status': 'error', 'message': e.toString()};
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<QuerySnapshot> viewChats(RoleType userRole, String userID) {
    return _chatCollection.where('${userRole.name}ID', isEqualTo: userID).get();
  }

  Stream<DocumentSnapshot> streamChat(String chatId) {
    return _chatCollection.doc(chatId).snapshots();
  }
}
