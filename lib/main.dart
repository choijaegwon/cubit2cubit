import 'package:cubit2cubit/cubits/color/color_cubit.dart';
import 'package:cubit2cubit/cubits/counter/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorCubit>(
          create: (context) => ColorCubit(),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(
            colorCubit: context.read<ColorCubit>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'cubit2cubit',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ColorCubit>().state.color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text(
                'Change Color',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {
                context.read<ColorCubit>().changeColor();
              },
            ),
            SizedBox(height: 20),
            Text(
              '${context.watch<CounterCubit>().state.counter}',
              style: TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text(
                'Increment Color',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {
                context.read<CounterCubit>().changeCounter();
              },
            ),
          ],
        ),
      ),
    );
  }
}
