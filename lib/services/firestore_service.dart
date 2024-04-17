
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get_it/get_it.dart';

import '../models/api_response.dart';
import '../models/user_details.dart';
import 'authentication_service.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
  FirebaseFirestore.instance.collection("users");

  final CollectionReference _productsCollectionReference =
  FirebaseFirestore.instance.collection("products");

  AuthenticationService get authenticationService =>
      GetIt.I<AuthenticationService>();

  Future createUser(UserDetails user) async {
    try {
      await _usersCollectionReference.doc(user.uid).set({
        'firstName': user.firstName,
        'lastName': user.lastName,
        'phoneNumber': user.phoneNumber,
        'address': user.address
      });
      return APIResponse<bool>(error: false);
    } catch (e) {
      return APIResponse<bool>(error: true, errorMessage: e.toString());
    }
  }


  Future updateUserDetails(Map<String, String> details) async {
    UserDetails? user = await authenticationService.currentUser();
    try {
      await _usersCollectionReference.doc(user!.uid).set({
        'skinTone': details['skinTone'],
        'skinType': details['skinType'],
      }, SetOptions(merge: true));
      UserDetails? userDetails;
      DocumentSnapshot doc = await _usersCollectionReference.doc(user.uid).get();



      if (doc.exists) {
        Map<String, dynamic>? userData = doc.data() as Map<String, dynamic>?;


        {
          userDetails = UserDetails.fromJson(userData!);
        }
      }
        else {
        {
          print("Document does not exists");
        }
      }
      return APIResponse<UserDetails>(data: userDetails, error: false);
    } catch (e) {
      return APIResponse<bool>(error: true, errorMessage: e.toString());
    }
  }

  Future getUserDetails() async {
    print("im running at getuserdetails function");
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final User? userik = _firebaseAuth.currentUser;
    print(userik!.uid!);
    UserDetails? userDetails;
    print("still running");
    try {
      print("still running intense");
      UserDetails? user = await authenticationService.currentUser();
      print("still running ultimate");
      print("user name is here ${user!.displayName!}");
      print("user uid is here ${user!.uid!}");

      DocumentSnapshot doc = await _usersCollectionReference.doc(user.uid).get();



      if (doc.exists) {
        print("doc exist ${doc.data()}");
        Map<String, dynamic>? userData = doc.data() as Map<String, dynamic>?;

        userDetails = UserDetails.fromJson(userData!);
      }
        else
          {print("Document does not exists");}

      return APIResponse<UserDetails>(data: userDetails, error: false);
    } catch (e) {
      print("ERROR HERE");
      print(e);
      return APIResponse<bool>(error: true, errorMessage: e.toString());
    }
  }

}
