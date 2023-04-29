import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> firebaseUser = Rx<User?>(null);
  final Rx<bool> _loading = false.obs;

  bool get loading => _loading.value;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.value = _auth.currentUser;
  }

  // FIREBASE LOGIN
  Future<void> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    _loading.value = true;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value = userCredential.user;
      Get.offNamed('/home');
      _loading.value = false;
    } on FirebaseAuthException catch (e) {
      _loading.value = false;
      Get.snackbar(
        'Login error: ',
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void logout() async {
    await _auth.signOut();
    firebaseUser.value = null;
  }
}
