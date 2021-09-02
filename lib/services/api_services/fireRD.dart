import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseUtil {
  DatabaseReference _counterRef;
  DatabaseReference _userRef;
  DatabaseReference _history;
  DatabaseReference _trends;
  // StreamSubscription<Event> _counterSubscription;
  // StreamSubscription<Event> _messagesSubscription;
  FirebaseDatabase database = new FirebaseDatabase();
  DatabaseReference _devices;
  DatabaseError error;

  static final FirebaseDatabaseUtil _instance =
      new FirebaseDatabaseUtil.internal();

  FirebaseDatabaseUtil.internal();

  factory FirebaseDatabaseUtil() {
    return _instance;
  }

  void initState() {
    _counterRef = FirebaseDatabase.instance.reference();
    _userRef = database.reference().child('switch');
    _devices =   database.reference().child('devices');
    _history =   database.reference().child('history');
    _trends =   database.reference().child('trends');
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _counterRef.keepSynced(true);

    // _counterSubscription = _counterRef.onValue.listen((Event event) {
    //   error = null;
    //   _counter = event.snapshot.value ?? 0;
    // }, onError: (Object o) {
    //   error = o;
    // });
  }

  DatabaseError getError() {
    return error;
  }

  DatabaseReference getCounter() {
    return _devices;
  }

  DatabaseReference getDevices() {
    return _userRef;
  } 
  
  DatabaseReference getHistory() {
    return _history;
  }
  DatabaseReference getTrensd() {
    return _trends;
  }

  // addUser(user) async {
  //   final TransactionResult transactionResult =
  //       await _counterRef.runTransaction((MutableData mutableData) async {
  //     mutableData.value = (mutableData.value ?? 0) + 1;
  //     return mutableData;
  //   });

  //   if (transactionResult.committed) {
  //     _userRef.push().set(<String, String>{
  //       "name": "" + user.name,
  //       "age": "" + user.age,
  //       "email": "" + user.email,
  //       "mobile": "" + user.mobile,
  //     }).then((_) {
  //       print('Transaction  committed.');
  //     });
  //   } else {
  //     print('Transaction not committed.');
  //     if (transactionResult.error != null) {
  //       print(transactionResult.error.message);
  //     }
  //   }
  // }

  // void deleteUser(user) async {
  //   await _userRef.child(user.id).remove().then((_) {
  //     print('Transaction  committed.');
  //   });
  // }

  Future updateDevice(status) async {
    await _userRef.update(status).then((_) {
    });
  }

  Future addHistory(data) async {
    await _history.push().set(data).then((_) {
    });
  }

  // Future addTrends(child) async {
  //   // await _trends.update({"$child":FieldValue.increment(1)}).then((_) {
  //   });
  // }

  // void dispose() {
  //   _messagesSubscription.cancel();
  //   _counterSubscription.cancel();
  // }
}