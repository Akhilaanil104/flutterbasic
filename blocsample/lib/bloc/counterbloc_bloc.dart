import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counterbloc_event.dart';
part 'counterbloc_state.dart';

class CounterblocBloc extends Bloc<CounterblocEvent, CounterblocState> {
  CounterblocBloc() : super(Intialstate()) {
    on<Increment>((event, emit) {
      return emit(CounterblocState(count: state.count+1));
      
    });
     on<Decrement>((event, emit) {
      return emit(CounterblocState(count: state.count-1));
      
    });


  }
}
