import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> register({
    required String email,
    required String password,
    required MyUserModel userModel,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      userModel.id = credential.user!.uid;
      await _firestore
          .collection(MyUserModel.collectionName)
          .doc(userModel.id)
          .set(userModel.toJson());

    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw 'This email is already in use. Please try logging in.';
        case 'weak-password':
          throw 'The password is too weak. Try a longer password.';
        case 'invalid-email':
          throw 'The email address is not valid.';
        case 'network-request-failed':
          throw 'Connection failed. Please check your internet.';
        default:
          throw e.message ?? 'An error occurred during registration.';
      }
    } on FirebaseException catch (e) {
      throw 'Database error: ${e.message}';
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }

  Future<UserCredential> login(String email, String password) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided.';
      } else if (e.code == 'network-request-failed') {
        throw 'Please check your internet connection.';
      } else {
        throw e.message ?? 'An unknown error occurred.';
      }
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw 'No account exists for this email.';
        case 'invalid-email':
          throw 'The email address is not valid.';
        case 'network-request-failed':
          throw 'Please check your internet connection.';
        default:
          throw e.message ?? 'An error occurred. Please try again.';
      }
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // 🔹 Start the sign-in flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw 'Sign in aborted by user';
      }

      // 🔹 Get auth details
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // 🔹 Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 🔹 Sign in to Firebase
      final userCredential =
      await _auth.signInWithCredential(credential);

      // 🔹 Check if user exists in Firestore
      final userDoc = await _firestore
          .collection(MyUserModel.collectionName)
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        final newUser = MyUserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email ?? '',
          name: userCredential.user!.displayName ?? '',
          avatar: userCredential.user!.photoURL ?? '',
          phone: '',
        );

        await _firestore
            .collection(MyUserModel.collectionName)
            .doc(newUser.id)
            .set(newUser.toJson());
      }

      return userCredential;

    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'account-exists-with-different-credential':
          throw 'Account exists with different sign-in method.';
        case 'invalid-credential':
          throw 'Invalid credentials.';
        case 'network-request-failed':
          throw 'Check your internet connection.';
        default:
          throw e.message ?? 'Google sign-in failed.';
      }
    } catch (e) {
      throw 'Something went wrong during Google sign-in.';
    }
  }
}