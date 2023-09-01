import 'package:flutter/services.dart';
import '../exports.dart';

class PropertyProvider with ChangeNotifier {
  Map<String, String> _status = {};
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  Map<String, String> get status => _status;

  static final _propertyCollection =
      FirebaseFirestore.instance.collection('properties');
  static final _storage = FirebaseStorage.instance;

  Future<void> create(Property property, List<XFile> images) async {
    _isLoading = true;
    notifyListeners();

    final List<String> imagesURL = [];

    try {
      for (XFile image in images) {
        imagesURL.add(await _uploadImage(await image.readAsBytes(),
            '${property.title}-${imagesURL.length + 1}'));
      }
      await _propertyCollection.add(property.toMap()).then(
        (value) {
          _propertyCollection
              .doc(value.id)
              .update({'id': value.id, 'imagesURL': imagesURL});
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

  Stream<QuerySnapshot> myProperties(String userID) {
    return _propertyCollection
        .where('uploadByUser', isEqualTo: userID)
        .snapshots();
  }

  Future<void> delete(String id) async {
    try {
      await _propertyCollection.doc(id).delete();
      _status = {'status': 'success', 'message': 'Successfully Removed!'};
    } on FirebaseException catch (e) {
      _status = {'status': 'error', 'message': e.message ?? ''};
    } catch (e) {
      _status = {'status': 'error', 'message': e.toString()};
    }
  }

  Future<String> _uploadImage(Uint8List file, String name) async {
    final ref = _storage.ref("images/properties/$name");
    final uploadTask = ref.putData(file);
    final snapshot = await uploadTask.whenComplete(() {});
    return await snapshot.ref.getDownloadURL();
  }
}
