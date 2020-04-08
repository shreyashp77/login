import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = Firestore.instance;

class Crud {
  FirebaseUser user;
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  // Future<void> addData(userData) async {
  //   if (isLoggedIn()) {
  //     // print('uid: ' + user.uid);
  //     Firestore.instance.collection('users').add(userData).catchError((e) {
  //       print(e);
  //     });
  //   } else {
  //     print('You need to be logged in');
  //   }
  // }
  // getData() async {
  //   return await Firestore.instance.collection('users').getDocuments();
  // }

  final String _collection = 'users';
  final Firestore _fireStore = Firestore.instance;

  getData() async {
    return await _fireStore.collection(_collection).getDocuments();
  }

  storeData(FirebaseUser user) async {
    DocumentReference documentRef =
        Firestore.instance.collection("users").document(user.uid);
    Firestore.instance.runTransaction((transaction) async {
      await documentRef.setData({
        'Name': user.displayName,
        'Email': user.email,
        'admin': false,
        'uid': user.uid
      });
      print("instance created");
    });
  }

  makeAdmin(String name, String mail, String uid) async {
    DocumentReference documentRef =
        Firestore.instance.collection("users").document(uid);
    Firestore.instance.runTransaction((transaction) async {
      await documentRef
          .setData({'Name': name, 'Email': mail, 'admin': true, 'uid': uid});
      print("admin created");
    });
  }

  // removeAdmin(String name, String mail, String uid) async {
  //   DocumentReference documentRef =
  //       Firestore.instance.collection("users").document(uid);
  //   Firestore.instance.runTransaction((transaction) async {
  //     await documentRef
  //         .setData({'Name': name, 'Email': mail, 'admin': false, 'uid': uid});
  //     print("admin removed");
  //   });
  // }

  addEventData(
      String title, String body, String topic, String sdate, String stime,
      {String url =
          "https://thelivenagpur.com/wp-content/uploads/2019/08/IMG-20190821-WA0031.jpg"}) async {
    DocumentReference documentRef =
        Firestore.instance.collection("notifications").document(topic);
    Firestore.instance.runTransaction(
      (transaction) async {
        await documentRef.setData({
          'Title': title,
          'Body': body,
          'Topic': topic,
          'Date': sdate,
          'Time': stime,
          'URL': url,
        });
        print("Notification Data added!");
      },
    );
  }

  editEventData(String topic,
      {String title,
      String body,
      String sdate,
      String stime,
      String url}) async {
    DocumentReference documentRef =
        Firestore.instance.collection("notifications").document(topic);
    Firestore.instance.runTransaction(
      (transaction) async {
        await documentRef.setData({
          'Title': title,
          if (body.isNotEmpty) 'Body': body,
          'Topic': topic,
          if (sdate != "Not set") 'Date': sdate,
          if (stime != "NOt set") 'Time': stime,
          if (url.isNotEmpty) 'URL': url,
        });
        print("Notification Data edited!");
      },
    );
  }

  deleteData(String topic) {
    DocumentReference documentRef =
        Firestore.instance.collection("notifications").document(topic);

    Firestore.instance.runTransaction(
      (transaction) async {
        await documentRef.delete();
        print("Notification Data added!");
      },
    );
  }
}
