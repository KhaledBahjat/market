import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class MyObserver implements BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    log(change.toString());
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    log('onClose: ${bloc.toString()}');
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    log('onCreate: ${bloc.toString()}');
  }

  @override
  void onDone(Bloc<dynamic, dynamic> bloc, Object? event, [Object? error, StackTrace? stackTrace]) {
    log('onDone: ${bloc.toString()}');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError: ${bloc.toString()}, $error');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    log('onEvent: ${bloc.toString()}, $event');
  }

  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    log('onTransition: ${bloc.toString()}, $transition');
  }
  
}