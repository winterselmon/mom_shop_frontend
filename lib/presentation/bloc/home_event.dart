part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeEventInit extends HomeEvent {
  const HomeEventInit() : super();
  @override
  List<Object> get props => [];
}

class SetViewMode extends HomeEvent {
  final String currentViewMode;
  const SetViewMode({required this.currentViewMode}) : super();
  @override
  List<Object> get props => [currentViewMode];
}
