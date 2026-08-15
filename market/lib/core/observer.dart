import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);

    log(
      '🟢 Created: ${bloc.runtimeType}',
      name: 'BLOC',
    );
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);

    log(
      '📌 ${bloc.runtimeType}\n'
      'Event: $event',
      name: 'BLOC EVENT',
    );
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    log(
      'Change 🔄  ${bloc.runtimeType}\n'
      'Current: ${change.currentState}\n'
      'Next: ${change.nextState}',
      name: 'BLOC',
    );
  }

  @override
  void onError(
    BlocBase bloc,
    Object error,
    StackTrace stackTrace,
  ) {
    log(
      '❌ ${bloc.runtimeType}\n'
      'Error: $error\n'
      'StackTrace: $stackTrace',
      name: 'BLOC ERROR',
    );

    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    log(
      '🔵 Closed: ${bloc.runtimeType}',
      name: 'BLOC',
    );

    super.onClose(bloc);
  }
}
