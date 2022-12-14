part of 'expand_menu_bloc.dart';

abstract class ExpandMenuState extends Equatable {
  const ExpandMenuState();

  @override
  List<Object> get props => [];
}

class ExpandMenuInitial extends ExpandMenuState {}

class ExpandeMenuState extends ExpandMenuState {
  final bool isExpand;

  const ExpandeMenuState({
    required this.isExpand,
  }) : super();
  @override
  List<Object> get props => [isExpand];
}

class SetCurrentMenuState extends ExpandMenuState {
  final String currentMenu;

  const SetCurrentMenuState({
    required this.currentMenu,
  }) : super();
  @override
  List<Object> get props => [currentMenu];
}
