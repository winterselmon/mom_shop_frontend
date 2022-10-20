import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'income_event.dart';
part 'income_state.dart';

class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
  IncomeBloc() : super(IncomeInitial()) {
    on<IncomeEventInit>((event, emit) {});

    on<SetViewMode>((event, emit) {
      String currentViewMode = event.currentViewMode;

      emit(CurrentViewModeState2(currentViewMode: currentViewMode));
    });
  }
}
