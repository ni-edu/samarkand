import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samarkand/traffic_light/bloc/traffic_light_page_bloc.dart';

class TrafficLightPage extends StatelessWidget {
  const TrafficLightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('APP')),
      body: BlocBuilder<TrafficLightPageBloc, TrafficLightPageState>(
        builder: (context, state) {
          if (state is TrafficLightPageLoading) {
            return const CircularProgressIndicator();
          } else if (state is TrafficLightPageLoaded) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Is the traffic light in the picture?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 400,
                  width: double.maxFinite,
                  child: Image.asset(state.image.item1),
                ),
                LinearProgressIndicator(
                  value:
                      state.answers.isEmpty ? 0 : 1 / state.answers.length,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          context.read<TrafficLightPageBloc>().add(
                              TrafficLightPageNextImage(
                                  answer: state.image.item2));
                        },
                        child: Text('YES')),
                    ElevatedButton(
                        onPressed: () {
                          context.read<TrafficLightPageBloc>().add(
                              TrafficLightPageNextImage(
                                  answer: !state.image.item2));
                        },
                        child: Text('No'))
                  ],
                )
              ],
            ));
          } else if (state is TrafficLightPageSuccess) {
            return Text('Congrats!');
          } else if (state is TrafficLightPageFail) {
            return Text('Fail');
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
