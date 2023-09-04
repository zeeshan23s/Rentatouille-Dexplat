import '../exports.dart';

class RentProvider with ChangeNotifier {
  Map<String, String> _status = {};
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  Map<String, String> get status => _status;

  static final _rentCollection = FirebaseFirestore.instance.collection('rents');

  Future<void> create(PropertyRent rent) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _rentCollection.doc(rent.propertyId).set(rent.toMap()).then(
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

  Future<QuerySnapshot<Map<String, dynamic>>> viewRents(
      Map<String, String> value) {
    return _rentCollection
        .where(value.entries.first.key, isEqualTo: value.entries.first.value)
        .get();
  }
}
