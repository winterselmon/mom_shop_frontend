import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'expand_menu_event.dart';
part 'expand_menu_state.dart';

class ExpandMenuBloc extends Bloc<ExpandMenuEvent, ExpandMenuState> {
  ExpandMenuBloc() : super(ExpandMenuInitial()) {
    on<ExpandMenuEventInit>((event, emit) {});

    on<SetExpandMenu>((event, emit) {
      bool isExpand = event.isExpand;
      if (isExpand) {
        emit(const ExpandeMenuState(isExpand: true));
      } else {
        emit(const ExpandeMenuState(isExpand: false));
      }
    });

    on<SetCurrentMenu>((event, emit) {
      String currentMenu = event.currentMenu;

      emit(SetCurrentMenuState(currentMenu: currentMenu));
    });
  }
}
