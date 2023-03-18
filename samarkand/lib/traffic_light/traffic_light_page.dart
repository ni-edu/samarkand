import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samarkand/constants.dart';
import 'package:samarkand/traffic_light/bloc/traffic_light_page_bloc.dart';

class TrafficLightPage extends StatefulWidget {
  const TrafficLightPage({Key? key}) : super(key: key);

  @override
  State<TrafficLightPage> createState() => _TrafficLightPageState();
}

class _TrafficLightPageState extends State<TrafficLightPage> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('APP'),
        backgroundColor: Constants.primaryColor,
      ),
      body: BlocConsumer<TrafficLightPageBloc, TrafficLightPageState>(
        listener: (context, state) {
          if (state is TrafficLightPageSuccess) {
            _controllerCenter.play();
          }
        },
        builder: (context, state) {
          if (state is TrafficLightPageLoading) {
            return const CircularProgressIndicator();
          } else if (state is TrafficLightPageLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      'Is the traffic light in the picture?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Image.asset(
                        state.image.item1,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  LinearProgressIndicator(
                    value: state.answers.isEmpty ? 0 : state.answers.length / 4,
                    color: Constants.primaryColor,
                    backgroundColor: Constants.primaryColor.withOpacity(0.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Constants.primaryColor,
                              ),
                              onPressed: () {
                                context.read<TrafficLightPageBloc>().add(
                                      TrafficLightPageNextImage(
                                        answer: state.image.item2,
                                      ),
                                    );
                              },
                              child: const Text('YES'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Constants.primaryColor,
                              ),
                              onPressed: () {
                                context.read<TrafficLightPageBloc>().add(
                                      TrafficLightPageNextImage(
                                        answer: !state.image.item2,
                                      ),
                                    );
                              },
                              child: const Text('No'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (state is TrafficLightPageSuccess) {
            return _TrafficLightPageCongrats(
              controllerCentar: _controllerCenter,
            );
          } else if (state is TrafficLightPageFail) {
            return _TrafficLightPageFail();
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _TrafficLightPageCongrats extends StatelessWidget {
  const _TrafficLightPageCongrats({required this.controllerCentar, Key? key})
      : super(key: key);
  final ConfettiController controllerCentar;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Congrats!',
              style: TextStyle(
                color: Constants.primaryColor,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'You have successfully donated money to animal shelter',
              style: TextStyle(
                color: Constants.primaryColor,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            Image.asset(
              'assets/img/puppy-g831c51326_1280.png',
              height: 200,
              width: double.maxFinite,
            )
          ],
        ),
        Align(
          child: ConfettiWidget(
            confettiController: controllerCentar,
            blastDirectionality: BlastDirectionality.explosive,
            // don't specify a direction, blast randomly
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ],
          ),
        ),
      ],
    );
  }
}

class _TrafficLightPageFail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          'You have failed!',
          style: TextStyle(
            color: Colors.red,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Image.asset(
          'assets/img/dog-g18ad9e7c6_1280.png',
          height: 200,
          width: double.maxFinite,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(150, 50),
            backgroundColor: Constants.primaryColor,
          ),
          onPressed: () {
            context.read<TrafficLightPageBloc>().add(TrafficLightPageInit());
          },
          child: const Text('Try again'),
        ),
      ],
    );
  }
}
