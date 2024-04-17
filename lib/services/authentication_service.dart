import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skincare/models/api_response.dart';
import 'package:skincare/models/user_details.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserDetails?>currentUser() async {
    final User? user = _firebaseAuth.currentUser;

    UserDetails user0 = UserDetails.optional(
        uid: user!.uid, displayName: ''!, email: user!.email!, photoUrl: '', firstName: '', lastName: '', phoneNumber: '', address: '', );

    return user0;
  }

  Future logout() async {
    try {
      return APIResponse<bool>(
        error: false,
      );
    } catch (e) {
      return APIResponse<bool>(error: true, errorMessage: e.toString());
    }
  }

//signup with email
  Future signUpWithEmail(String email, String password) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (authResult.user != null) {
        User user = authResult.user!;

        return APIResponse<UserDetails>(
          error: false,
          data: UserDetails.optional(
              uid: user.uid, displayName: user.displayName, email: user.email),
        );
      } else {
        return APIResponse<bool>(
            error: true, errorMessage: 'User registration failed');
      }
    } catch (e) {
      return APIResponse<bool>(error: true, errorMessage: e.toString());
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the Google sign-in flow
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        // Obtain the GoogleSignInAuthentication object
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        // Create a new credential
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // Sign in to Firebase with the Google credential
        final UserCredential authResult =
        await _firebaseAuth.signInWithCredential(credential);

        return authResult.user;
      } else {
        // Handle if the user cancels the Google sign-in process
        return null;
      }
    } catch (e) {
      // Handle sign-in errors
      print('Error signing in with Google: $e');
      return null;
    }
  }

  //signin with email
  Future signInWithEmail(String email, String password) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (authResult.user != null) {
        return APIResponse<UserDetails>(
          error: false,
          data: UserDetails.optional(
            uid: authResult.user!.uid!,
            displayName: authResult.user!.displayName,
            email: authResult.user!.email,
          ),
        );
      } else {
        return APIResponse<bool>(error: true, errorMessage: 'Login failed');
      }
    } catch (e) {
      return APIResponse<bool>(error: true, errorMessage: e.toString());
    }
  }
}
