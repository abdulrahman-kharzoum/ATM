import 'package:flutter/material.dart';
import 'package:fast_rsa/fast_rsa.dart';
import 'dart:convert';

class KeyGenerationScreen extends StatefulWidget {
  const KeyGenerationScreen({super.key});

  @override
  State<KeyGenerationScreen> createState() => _KeyGenerationScreenState();
}

class _KeyGenerationScreenState extends State<KeyGenerationScreen> {
  String publicKey = '';
  String privateKey = '';
  String inputMessage = '';
  String encryptedMessage = '';
  String decryptedMessage = '';

  // Generate RSA keys
  Future<void> generateKeys() async {
    final keyPair = await RSA.generate(1024);
    setState(() {
      publicKey = keyPair.publicKey;
      privateKey = keyPair.privateKey;
    });
  }

  // Encrypt the input message using the public key
  Future<void> encryptMessage() async {
    if (publicKey.isEmpty) return;
    final encrypted = await RSA.encryptPKCS1v15(inputMessage, publicKey);
    setState(() {
      encryptedMessage = encrypted;
    });
  }

  // Decrypt the encrypted message using the private key
  Future<void> decryptMessage() async {
    if (privateKey.isEmpty || encryptedMessage.isEmpty) return;
    final decrypted = await RSA.decryptPKCS1v15(encryptedMessage, privateKey);
    setState(() {
      decryptedMessage = decrypted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RSA Key Generation and Encryption')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: generateKeys,
                  child: const Text('Generate RSA Keys'),
                ),
              ),
              const SizedBox(height: 20),
              if (publicKey.isNotEmpty && privateKey.isNotEmpty) ...[
                const Text('Public Key:', style: TextStyle(fontWeight: FontWeight.bold)),
                SelectableText(publicKey),
                const SizedBox(height: 20),
                const Text('Private Key:', style: TextStyle(fontWeight: FontWeight.bold)),
                SelectableText(privateKey),
                const SizedBox(height: 20),
              ],
              const Text('Enter message to encrypt:', style: TextStyle(fontWeight: FontWeight.bold)),
              TextField(
                onChanged: (value) {
                  setState(() {
                    inputMessage = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Enter message',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: encryptMessage,
                child: const Text('Encrypt Message'),
              ),
              const SizedBox(height: 20),
              if (encryptedMessage.isNotEmpty) ...[
                const Text('Encrypted Message:', style: TextStyle(fontWeight: FontWeight.bold)),
                SelectableText(encryptedMessage),
                const SizedBox(height: 20),
              ],
              ElevatedButton(
                onPressed: decryptMessage,
                child: const Text('Decrypt Message'),
              ),
              const SizedBox(height: 20),
              if (decryptedMessage.isNotEmpty) ...[
                const Text('Decrypted Message:', style: TextStyle(fontWeight: FontWeight.bold)),
                SelectableText(decryptedMessage),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
