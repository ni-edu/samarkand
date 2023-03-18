import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samarkand/traffic_light/helper/image_map.dart';
import 'package:tuple/tuple.dart';

part 'traffic_light_page_event.dart';

part 'traffic_light_page_state.dart';

class TrafficLightPageBloc
    extends Bloc<TrafficLightPageEvent, TrafficLightPageState> {
  TrafficLightPageBloc() : super(TrafficLightPageLoading()) {
    on<TrafficLightPageInit>((event, emit) {
      final randomImage = ImageMap.data.keys
          .toList()[_random.nextInt(ImageMap.data.keys.length)];
      emit(TrafficLightPageLoaded(
          image: Tuple2(randomImage, ImageMap.data[randomImage]!),
          answers: const []));
    });
    on<TrafficLightPageNextImage>((event, emit) {
      if (state is! TrafficLightPageLoaded) return;
      final currState = state as TrafficLightPageLoaded;
      if (currState.answers.length >= 3 &&
          currState.answers.every((element) => element)) {
        emit(TrafficLightPageSuccess());
        return;
      } else if (currState.answers.length >= 3) {
        emit(TrafficLightPageFail());
        return;
      }
      final randomImage = ImageMap.data.keys
          .toList()[_random.nextInt(ImageMap.data.keys.length)];
      print(randomImage);
      final newAnswers = List<bool>.from(currState.answers)..add(event.answer);
      emit(TrafficLightPageLoaded(
          image: Tuple2(randomImage, ImageMap.data[randomImage]!),
          answers: newAnswers));
    });
  }

  static final Random _random = Random();
}
