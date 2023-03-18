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
      final randomPicker =
          List<int>.generate(ImageMap.data.length, (index) => index)
            ..shuffle();
      final randomInt = randomPicker.removeLast();
      final randomImage = ImageMap.data.keys.toList()[randomInt];
      final previousImages = randomPicker;
      emit(
        TrafficLightPageLoaded(
          previousImages: previousImages,
          image: Tuple2(randomImage, ImageMap.data[randomImage]!),
          answers: const [],
        ),
      );
    });
    on<TrafficLightPageNextImage>((event, emit) {
      if (state is! TrafficLightPageLoaded) return;
      final currState = state as TrafficLightPageLoaded;
      final newAnswers = List<bool>.from(currState.answers)..add(event.answer);
      if (newAnswers.length == 4 && newAnswers.every((element) => element)) {
        emit(TrafficLightPageSuccess());
        return;
      } else if (newAnswers.length == 4) {
        emit(TrafficLightPageFail());
        return;
      }
      final randomInt = currState.previousImages.removeLast();

      final randomImage = ImageMap.data.keys.toList()[randomInt];
      emit(
        TrafficLightPageLoaded(
          previousImages: currState.previousImages,
          image: Tuple2(randomImage, ImageMap.data[randomImage]!),
          answers: newAnswers,
        ),
      );
    });
  }

  static final Random _random = Random();
}
