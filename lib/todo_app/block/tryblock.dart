import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'block.dart';
import 'cubit.dart';

class CounterClass extends StatefulWidget {
  @override
  _CounterClassState createState() => _CounterClassState();
}

class _CounterClassState extends State<CounterClass> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterState>(
        listener: (context, state){
          //if(state is CounterPlusState) print("Plus #${state.counter}");
          //if(state is CounterMinusState) print("Minus #${state.counter}");
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: () => CounterCubit.get(context).minus(),
                    child: Text(
                      '-Minus',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    ' ${CounterCubit.get(context).counter} ',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                    onPressed: () => CounterCubit.get(context).plus(),
                    child: Text(
                      'Plus+',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
