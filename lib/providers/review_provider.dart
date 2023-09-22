import '../exports.dart';

class ReviewProvider with ChangeNotifier {
  Map<String, String> _status = {};
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  Map<String, String> get status => _status;

  static final _reviewCollection =
      FirebaseFirestore.instance.collection('reviews');

  Future<void> create(PropertyReview review) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _reviewCollection.doc(review.propertyId).set(review.toMap()).then(
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

  Stream<DocumentSnapshot> viewReview(String propertyId) {
    return _reviewCollection.doc(propertyId).snapshots();
  }

  Future<void> update(String propertyId, int review, String userId) async {
    _isLoading = true;
    notifyListeners();

    List<dynamic> reviewProviderIds = [];
    double reviews = 0;

    try {
      await _reviewCollection.doc(propertyId).get().then((value) {
        if (value.data()!.entries.first.key == 'reviewProviderIds') {
          if (value.data()!.entries.first.value.isNotEmpty) {
            reviewProviderIds = value.data()!.entries.first.value;
            reviews = double.parse(value.data()!.entries.last.value.toString());
          }
        } else {
          if (value.data()!.entries.last.value.isNotEmpty) {
            reviewProviderIds = value.data()!.entries.last.value;
            reviews =
                double.parse(value.data()!.entries.first.value.toString());
          }
        }
      });

      reviewProviderIds.add(userId);
      reviews = ((reviews * (reviewProviderIds.length - 1)) + review) /
          (reviewProviderIds.length);

      await _reviewCollection.doc(propertyId).update(
          {'reviewProviderIds': reviewProviderIds, 'reviews': reviews}).then(
        (value) {
          _status = {'status': 'success', 'message': 'Successfully Created!'};
        },
      );
    } on FirebaseException catch (e) {
      _status = {'status': 'error', 'message': e.message ?? ''};
    } catch (e) {
      debugPrint(e.toString());
      _status = {'status': 'error', 'message': e.toString()};
    }

    _isLoading = false;
    notifyListeners();
  }
}
