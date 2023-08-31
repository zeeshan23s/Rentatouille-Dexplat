import '../exports.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Map<String, String> _status = {};
  bool _isLoading = false;
  bool _isNewUser = false;

  User? get currentUser => _firebaseAuth.currentUser;
  bool get isNewUser => _isNewUser;
  Map<String, String> get status => _status;
  bool get isLoading => _isLoading;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      _status = {'status': 'success', 'message': 'Login Successful!'};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _status = {
          'status': 'error',
          'message': 'No user found for that email.'
        };
      } else if (e.code == 'wrong-password') {
        _status = {
          'status': 'error',
          'message': 'Wrong password provided for that user.'
        };
      }
    } catch (e) {
      _status = {'status': 'error', 'message': e.toString()};
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await sendEmailVerification();
      _isNewUser = true;
      _status = {'status': 'success', 'message': 'Successfully Registered!'};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _status = {
          'status': 'error',
          'message': 'The password provided is too weak.'
        };
      } else if (e.code == 'email-already-in-use') {
        _status = {
          'status': 'error',
          'message': 'The account already exists for that email.'
        };
      }
    } catch (e) {
      _status = {'status': 'error', 'message': e.toString()};
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    notifyListeners();
  }

  Future<void> forgotPassword(String email) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      _status = {
        'status': 'success',
        'message': 'Password reset email have been sent to your email account.'
      };
    } on FirebaseException catch (e) {
      _status = {'status': 'error', 'message': e.message ?? ""};
    } catch (e) {
      _status = {'status': 'error', 'message': e.toString()};
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> googleLogin() async {
    _isLoading = true;
    notifyListeners();

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential? user =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (user.additionalUserInfo != null) {
        _isNewUser = user.additionalUserInfo!.isNewUser;
      }

      _status = {'status': 'success', 'message': 'Login Successful!'};
    } on FirebaseException catch (e) {
      _status = {'status': 'error', 'message': e.message ?? ""};
    } catch (e) {
      _status = {'status': 'error', 'message': e.toString()};
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> sendEmailVerification() async {
    _isLoading = true;
    notifyListeners();

    try {
      if (_firebaseAuth.currentUser != null) {
        await _firebaseAuth.currentUser?.sendEmailVerification();
      }
      _status = {
        'status': 'success',
        'message': 'Verification email have been send successfully!'
      };
    } on FirebaseException catch (e) {
      _status = {'status': 'error', 'message': e.message ?? ''};
    } catch (e) {
      _status = {'status': 'error', 'message': e.toString()};
    }

    _isLoading = false;
    notifyListeners();
  }
}
