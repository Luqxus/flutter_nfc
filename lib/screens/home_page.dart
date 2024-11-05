import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nfc/bloc/nfc/bloc.dart';
import 'package:flutter_nfc/bloc/nfc/event.dart';
import 'package:flutter_nfc/screens/widgets/nfc_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFC Demo'),
        elevation: 2,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Card for NFC Read
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.nfc_rounded,
                        size: 48,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Read NFC Tag',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Scan an NFC tag to read its content',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () => showNfcDialog(context),
                        icon: const Icon(Icons.sensors),
                        label: const Text('Start Scanning'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Card for NFC Write
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.send_to_mobile_rounded,
                        size: 48,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Write to NFC Tag',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Transfer data to another NFC device',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () => showNfcDialog(
                          context,
                          isTransferMode: true,
                        ),
                        icon: const Icon(Icons.send),
                        label: const Text('Start Transfer'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Example usage:
  void showNfcDialog(BuildContext context, {bool isTransferMode = false}) {
    showModalBottomSheet(
      context: context,
      // barrierDismissible: false,
      builder: (context) => Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        child: BlocProvider(
          create: (context) => NfcBloc()
            ..add(
              isTransferMode ? NfcTransferEvent() : NfcReceiveEvent(),
            ),
          child: NfcDialog(isTransferMode: isTransferMode),
        ),
      ),
    );
  }
}
