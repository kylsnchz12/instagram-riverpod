import 'package:flutter/foundation.dart' show immutable;
import 'package:indagram/state/constants/firebase_collection_name.dart';
import 'package:indagram/state/constants/firebase_field_name.dart';
import 'package:indagram/state/posts/typedefs/user_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indagram/state/user_info/models/user_info_payloads.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();
  Future<bool> saveUserInfo({
    required UserId userId,
    required String displayName,
    required String? email,
  }) async {
    try {
      // check if user info is already stored in firebase
      final userInfo = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .where(FirebaseFieldName.userId, isEqualTo: userId)
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        // user found in the firebase
        await userInfo.docs.first.reference.update({
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email ?? '',
        });
        return true;
      }

      // if user is not yet on the firebase
      final payload = UserInfoPayload(
          userId: userId, displayName: displayName, email: email);
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .add(payload);
      return true;
    } catch (e) {
      return false;
    }
  }
}
