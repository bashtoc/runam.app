import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class DbHelper {
  CollectionReference dbCollection =
  FirebaseFirestore.instance.collection('users');

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? user = FirebaseAuth.instance.currentUser;

//Add todo
  Future<String> add({String? firstName, String? lastName}) async {
    try {
      String formattedDate = DateFormat.yMMMd().format(DateTime.now());
      final data = {
        'firstName': firstName,
        'lastName': lastName,
        'time': formattedDate,
        'role': 'user',
      };

      await dbCollection.doc(user!.uid).collection('usersInfo').add(data);

      return 'new user Added';
    } catch (e) {
      return e.toString();
    }
  }


  ///signout

  signOut(){


    _auth.signOut();
  }


///update
  Future<String> update( {String? id, String?  firstName, String? lastName}) async {
    try {
      String formattedDate = DateFormat.yMMMd().format(DateTime.now());
      final data = {
        'firstName': firstName,
        'lastName': lastName,
        'time': formattedDate,

      };

      dbCollection.doc(user!.uid).collection('usersInfo').doc(id).set(data, );

      return 'new user Updated';
    } catch (e) {
      return e.toString();
    }
  }

  ///delete
  Future<String> delete({String? id, String? title, String? story}) async {
    try {
      dbCollection.doc(user!.uid).collection('usersInfo').doc(id).delete();

      return 'info Deleted';
    } catch (e) {
      return e.toString();
    }
  }
}