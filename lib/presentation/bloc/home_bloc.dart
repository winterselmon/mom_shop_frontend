import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});

    on<SetViewMode>((event, emit) {
      String currentViewMode = event.currentViewMode;

      emit(CurrentViewModeState(currentViewMode: currentViewMode));
    });
  }
}
