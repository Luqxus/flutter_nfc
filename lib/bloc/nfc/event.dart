import 'package:equatable/equatable.dart';

class NfcEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NfcTransferEvent extends NfcEvent {}

class NfcReceiveEvent extends NfcEvent {}

class NfcDisposeEvent extends NfcEvent {}
