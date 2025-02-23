import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:bloc/bloc.dart';

import 'internet_event.dart';
import 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState>{

  Connectivity _connectivity = Connectivity();

  StreamSubscription? connectivitySubscription;


  InternetBloc() : super(InternetInitialState()){
    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));
    on<InternetGainedEvent>((event, emit) => emit(InternetGainedState()));


    _connectivity.onConnectivityChanged.listen((result){
      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
        add(InternetGainedEvent());
      }
      else{
        add(InternetLostEvent());
      }
    });

  }

  @override
  Future<void> close(){
    connectivitySubscription?.cancel();
    return super.close();
  }
}