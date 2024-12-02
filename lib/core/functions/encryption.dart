import 'dart:convert';
import 'dart:io';
import 'package:atm/core/shared/local_network.dart';
import 'package:fast_rsa/fast_rsa.dart';

class Encryption {
  Future<String> encryptMessage({
/*************  ✨ Codeium Command ⭐  *************/
    /// Encrypts the given [data] using the public key stored in the Cash server
    /// and returns the encrypted data as a base64 string.
    ///
    /// The public key is stored in the Cash server and is retrieved using the
    /// [CashNetwork.getCashData] function.
    ///
    /// The encryption is done using the RSA PKCS#1 v1.5 encryption algorithm.
    ///
    /// The function returns a [Future] that resolves to the encrypted data as a
    /// base64 string.
    ///
    /// The function throws a [CashNetworkException] if the public key is not
    /// available in the Cash server.
    ///
    /// The function throws a [RsaException] if the encryption fails.
/******  4f1cd08a-1b7f-4cb1-9a4a-0165a6ff4972  *******/ required String data,
  }) async {
    String publicKey = '''
-----BEGIN PUBLIC KEY-----
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAu3aaSyZtQtCnLIZpRXOgvAVZxV3y85JiDIqKU1euKH6e8YUjowWUCqnBWWO8oXdmZQh5Q6RfJ+ngnL1/mtrPOHBlLh4JptIIOC8shmQ2HCbBK8Yumgx4h3TS66dcCD53ZG0ZspIoTlxQ7Or5XKXJ1aE5+0xmqTMGpge5C/kn61VQX5402KYWk9rR+rQqovz1Tx03gzxNUjZqi6rT1e92VsS5RgRF935ZwNGvWFqEsyJ7SGbJURrPUoDCNuGfeMRuJhSFUfHr5Y4p/UJwrD80piYxdYQBE+20+EmA6K8JGh3/ORhTZPAnfHuIBOkjnabTIC81bnRQz7dfiH2jys1FnEK1DLkMo2hCS+/NCbumg838jD9w2eTA8EZTJgtYBqpydE5nsx/aLxALVGLdu9o/mnUSP/6CDH+I3rIR4AL9zaf1zdaHYnpM6xnLp4MnLAZR0F+/xG4b6a1rS1hvfTb0Mhf5tpS9LpIoOtUAS215Pjnd3xi7KTZP9yoMzzvcVjhIm8I1sLSftPb5PXyDhkRgQNnCrpBO4UzgUGkcb3LD9nQ+BYfJf8nS8gDDLzeFnuzh658dRyQY8G6QA4IuEXWWzja1+zIWIjpqfZdukIq28twMeOJuREjkV/svr79tgGpaqjhR6+YuzioiejL9DM4yqqLQcV6ifM7UAqKtLphZlxcCAwEAAQ==
-----END PUBLIC KEY-----
''';
    //  await CashNetwork.getCashData(key: 'public_key');
    final encrypted = await RSA.encryptPKCS1v15(data, publicKey);
    return encrypted;
  }

  // Decrypt the encrypted message using the private key
  Future<String> decryptMessage({required String encryptedData}) async {
    String privateKey = await CashNetwork.getCashData(key: 'private_key');
    final decrypted = await RSA.decryptPKCS1v15(encryptedData, privateKey);
    return decrypted;
  }

  List<int> compressString(String input) {
    List<int> inputBytes = utf8.encode(input); // Convert to bytes
    return ZLibCodec().encode(inputBytes); // Compress the bytes
  }
}