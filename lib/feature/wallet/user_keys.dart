import 'dart:typed_data';

import 'package:healtheye/data/user.dart';
import 'package:healtheye/utils/keys.dart';

class UserKeys {
  String privateKey;
  String publicKey;
  Uint8List symmetricKey;

  UserKeys({
    required this.privateKey,
    required this.publicKey,
    required this.symmetricKey,
  });

  static Future<UserKeys> fromStorage() async {
    final privateKey = await getPrivateKey();
    final publicKey = getPublicKey(privateKey);
    final symmetricKey = deriveSymmetricKey(privateKey);
    return UserKeys(
      privateKey: privateKey,
      publicKey: publicKey,
      symmetricKey: symmetricKey,
    );
  }

  static Future<UserKeys> fetch(User user) async {
    await Future.delayed(const Duration(seconds: 2));
    return UserKeys.fromStorage();
  }

  Future<void> remove() async {
    //
  }
}
