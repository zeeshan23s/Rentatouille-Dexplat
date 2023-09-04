import 'dart:math';

import '../exports.dart';

class RentProvider with ChangeNotifier {
  Map<String, String> _status = {};
  bool _isLoading = false;
  bool _requestLoading = false;

  bool get isLoading => _isLoading;
  bool get requestLoading => _requestLoading;
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

  Future<void> requestRent(String propertyId, List<dynamic> rent) async {
    _requestLoading = true;
    notifyListeners();

    DateTime current = DateTime.now();
    if (!rent.any((element) =>
        element['rentMonth'] == current.month &&
        element['rentYear'] == current.year)) {
      rent.add({
        'rentMonth': current.month,
        'rentYear': current.year,
        'receivedDate': null
      });

      try {
        await _rentCollection
            .doc(propertyId)
            .update({'rentHistory': rent}).then(
          (value) {
            _status = {'status': 'success', 'message': 'Request Created!'};
          },
        );
      } on FirebaseException catch (e) {
        _status = {'status': 'error', 'message': e.message ?? ''};
      } catch (e) {
        _status = {'status': 'error', 'message': e.toString()};
      }
    } else {
      await Future.delayed(
        const Duration(milliseconds: 800),
      );
    }

    _requestLoading = false;
    notifyListeners();
  }

  Future<void> receiveRent(String propertyId, List<dynamic> rent) async {
    _isLoading = true;
    notifyListeners();

    DateTime current = DateTime.now();

    rent.removeWhere((element) =>
        element['rentMonth'] == current.month &&
        element['rentYear'] == current.year);

    rent.add({
      'rentMonth': current.month,
      'rentYear': current.year,
      'receivedDate': Timestamp.now()
    });

    try {
      await _rentCollection.doc(propertyId).update({'rentHistory': rent}).then(
        (value) {
          _status = {'status': 'success', 'message': 'Received Created!'};
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
}
