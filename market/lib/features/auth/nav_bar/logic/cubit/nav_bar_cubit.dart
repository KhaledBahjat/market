import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarInitial());
  int currentINdex=0;
  void changeCurrentINdex(int idx){
    currentINdex=idx;
    emit(IndexChange());
  }
}
