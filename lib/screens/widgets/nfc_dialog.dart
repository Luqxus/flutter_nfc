import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nfc/bloc/nfc/bloc.dart';
import 'package:flutter_nfc/bloc/nfc/event.dart';
import 'package:flutter_nfc/bloc/nfc/state.dart';

class NfcDialog extends StatelessWidget {
  final bool isTransferMode;

  const NfcDialog({
    super.key,
    this.isTransferMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NfcBloc, NfcState>(
      listener: (context, state) {
        if (state is NfcErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
          Navigator.pop(context);
        } else if (state is NfcSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Column(
              children: [
                if (state is NfcInitialState) ...[
                  const CircularProgressIndicator(),
                  const SizedBox(height: 32),
                  Text(
                    isTransferMode
                        ? 'Hold your device near the receiving device'
                        : 'Hold your device near the NFC tag',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Keep your device still until the transfer is complete',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ],
            ),
            // const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        context.read<NfcBloc>().add(NfcDisposeEvent());
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
