import 'package:flutter/services.dart';
import '../exports.dart';

class UserProvider with ChangeNotifier {
  AppUser? _appUser;
  Map<String, String> _status = {};
  bool _isLoading = false;

  AppUser? get appUser => _appUser;
  bool get isLoading => _isLoading;
  Map<String, String> get status => _status;

  static final _userCollection = FirebaseFirestore.instance.collection('user');
  static final _storage = FirebaseStorage.instance;

  Future<void> create(AppUser user) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _userCollection.doc(user.id).set(user.toMap()).then((value) =>
          _status = {'status': 'success', 'message': 'Successfully Created!'});
    } on FirebaseException catch (e) {
      _status = {'status': 'error', 'message': e.message ?? ''};
    } catch (e) {
      _status = {'status': 'error', 'message': e.toString()};
    }

    _isLoading = false;
    notifyListeners();
  }

  Stream<DocumentSnapshot> read(String id) {
    return _userCollection.doc(id).snapshots();
  }

  Future<void> delete(String id) async {
    try {
      await _userCollection.doc(id).delete();
      _status = {'status': 'success', 'message': 'Successfully Removed!'};
    } on FirebaseException catch (e) {
      _status = {'status': 'error', 'message': e.message ?? ''};
    } catch (e) {
      _status = {'status': 'error', 'message': e.toString()};
    }
  }

  Future<void> updateImage(String id, Uint8List file, String name) async {
    _isLoading = true;
    notifyListeners();

    String imageURL = await _uploadImage(file, name);

    try {
      await _userCollection.doc(id).update({'imageURL': imageURL}).then(
          (value) => _status = {
                'status': 'success',
                'message': 'Successfully Updated!'
              });
    } on FirebaseException catch (e) {
      _status = {'status': 'error', 'message': e.message ?? ''};
    } catch (e) {
      _status = {'status': 'error', 'message': e.toString()};
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<String> _uploadImage(Uint8List file, String name) async {
    final ref = _storage.ref("images/$name");
    final uploadTask = ref.putData(file);
    final snapshot = await uploadTask.whenComplete(() {});
    return await snapshot.ref.getDownloadURL();
  }
}
