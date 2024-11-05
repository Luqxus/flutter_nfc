import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nfc/bloc/nfc/event.dart';
import 'package:flutter_nfc/bloc/nfc/state.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NfcBloc extends Bloc<NfcEvent, NfcState> {
  NfcBloc() : super(NfcInitialState()) {
    on<NfcTransferEvent>(_transfer);
    on<NfcReceiveEvent>(_nfcReceive);
    on<NfcDisposeEvent>(_dispose);
  }

  /// NFC transfer handler
  _transfer(NfcTransferEvent event, Emitter emit) async {
    // Check if NFC is available and supported
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (!isAvailable) {
      emit(NfcErrorState("NFC not supported or check permissions"));
      return;
    }

    // Start NFC session
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        // Create an Ndef instance from the tag
        Ndef? ndef = Ndef.from(tag);

        // Check if the tag supports NDEF
        if (ndef == null) {
          // NDEF is not supported by the tag
          emit(NfcErrorState("Tag is not compatible with NDEF"));
          return;
        }

        // Create a message to send via NDEF
        final message = NdefMessage([
          NdefRecord.createText("Some message"),
        ]);

        // Write the message to the tag
        try {
          await ndef.write(message);
          emit(NfcSuccessState("Transmission successful"));
        } catch (e) {
          emit(NfcErrorState("Failed to write to tag: $e"));
        }
      },
    );

    // Stop NFC session
    NfcManager.instance.stopSession();
  }

  /// NFC receive handler
  _nfcReceive(NfcReceiveEvent event, Emitter emit) async {
    // Check if NFC is available and supported
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (!isAvailable) {
      emit(NfcErrorState("NFC not supported or check permissions"));
      return;
    }

    // Start NFC session
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        // Create an Ndef instance from the tag
        Ndef? ndef = Ndef.from(tag);

        // Check if the tag supports NDEF
        if (ndef == null) {
          // NDEF is not supported by the tag
          emit(NfcErrorState("Tag is not compatible with NDEF"));
          return;
        }

        // Try to read the NDEF message from the tag
        try {
          NdefMessage message = await ndef.read();
          emit(NfcSuccessState(
              "Received message: ${message.records.first.toString()}"));
        } catch (e) {
          emit(NfcErrorState("Failed to read from tag: $e"));
        }
      },
    );

    // Stop NFC session
    NfcManager.instance.stopSession();
  }

  /// Dispose handler
  _dispose(NfcDisposeEvent event, Emitter emit) async {
    await NfcManager.instance.stopSession();
  }
}
