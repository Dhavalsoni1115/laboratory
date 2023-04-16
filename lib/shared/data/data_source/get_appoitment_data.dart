import 'package:cloud_firestore/cloud_firestore.dart';

class Appoitment {
  getAppoitment(String appoitmentId) async {
    try {
      final firebase = FirebaseFirestore.instance.collection('appointments');
      var selectedAppoitmentData = firebase
          .doc(appoitmentId)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          // print('object');
          // print(documentSnapshot.data());
          var id = documentSnapshot.id;
          //var data = StaffModel.fromJson(documentSnapshot.data());
          return {'id': id, ...documentSnapshot.data()};
          // documentSnapshot.data();
        } else {
          print('Appoitment does not exist on the database');
        }
      });
      return selectedAppoitmentData;
    } catch (e) {
      print(e);
    }
  }

//   getAllAppoitmentData() async {
//     dynamic staffId;
//     dynamic staffData;

//     try {
//       QuerySnapshot querySnapshot =
//           await FirebaseFirestore.instance.collection('appointments').get();
//       staffData = querySnapshot.docs.map((doc) {
//         staffId = doc.id;
//         doc.data();
//         return {'id': staffId, ...doc.data()};
//       }).toList();
//       return staffData;
//     } catch (e) {
//       print(e);
//     }
//   }
 }
