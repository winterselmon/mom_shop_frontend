part of 'income_bloc.dart';

abstract class IncomeEvent extends Equatable {
  const IncomeEvent();

  @override
  List<Object> get props => [];
}

class IncomeEventInit extends IncomeEvent {
  const IncomeEventInit() : super();
  @override
  List<Object> get props => [];
}

class SetViewMode extends IncomeEvent {
  final String currentViewMode;
  const SetViewMode({required this.currentViewMode}) : super();
  @override
  List<Object> get props => [currentViewMode];
}
