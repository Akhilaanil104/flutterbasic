part of 'counterbloc_bloc.dart';

@immutable
sealed class CounterblocEvent {}

class Increment extends CounterblocEvent{}

class Decrement extends CounterblocEvent{}
