import 'package:flutter/material.dart';
import 'package:fast_rsa/fast_rsa.dart';

class KeyGenerationScreen extends StatefulWidget {
  const KeyGenerationScreen({super.key});

  @override
  State<KeyGenerationScreen> createState() => _KeyGenerationScreenState();
}

class _KeyGenerationScreenState extends State<KeyGenerationScreen> {
  String publicKey = '';
  String privateKey = '';

  Future<void> generateKeys() async {
    final keyPair = await RSA.generate(2048);
    setState(() {
      publicKey = keyPair.publicKey;
      privateKey = keyPair.privateKey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Key Generation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
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
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
