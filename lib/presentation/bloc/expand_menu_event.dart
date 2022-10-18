part of 'expand_menu_bloc.dart';

abstract class ExpandMenuEvent extends Equatable {
  const ExpandMenuEvent();

  @override
  List<Object> get props => [];
}

class ExpandMenuEventInit extends ExpandMenuEvent {
  const ExpandMenuEventInit() : super();
  @override
  List<Object> get props => [];
}

class SetExpandMenu extends ExpandMenuEvent {
  final bool isExpand;
  const SetExpandMenu({required this.isExpand}) : super();
  @override
  List<Object> get props => [isExpand];
}
