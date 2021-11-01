abstract class CounterState{}

class CounterInitialState extends CounterState{}

class CounterPlusState extends CounterState{
  final counter;

  CounterPlusState(this.counter);
}

class CounterMinusState extends CounterState{
  final counter;
  CounterMinusState(this.counter);
}