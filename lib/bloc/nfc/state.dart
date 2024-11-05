import 'package:equatable/equatable.dart';

class NfcState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NfcInitialState extends NfcState {}

class NfcSuccessState extends NfcState {
  final String message;

  NfcSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class NfcLoadingState extends NfcState {}

class NfcErrorState extends NfcState {
  final String message;

  NfcErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
