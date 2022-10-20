part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class CurrentViewModeState extends HomeState {
  final String currentViewMode;

  const CurrentViewModeState({
    required this.currentViewMode,
  }) : super();
  @override
  List<Object> get props => [currentViewMode];
}
