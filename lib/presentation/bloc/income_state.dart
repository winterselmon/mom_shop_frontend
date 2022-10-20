part of 'income_bloc.dart';

abstract class IncomeState extends Equatable {
  const IncomeState();

  @override
  List<Object> get props => [];
}

class IncomeInitial extends IncomeState {}

class CurrentViewModeState2 extends IncomeState {
  final String currentViewMode;

  const CurrentViewModeState2({
    required this.currentViewMode,
  }) : super();
  @override
  List<Object> get props => [currentViewMode];
}
