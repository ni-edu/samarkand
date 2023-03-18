part of 'traffic_light_page_bloc.dart';

abstract class TrafficLightPageState extends Equatable {
  const TrafficLightPageState();
}

class TrafficLightPageLoading extends TrafficLightPageState {
  @override
  List<Object> get props => [];
}

class TrafficLightPageLoaded extends TrafficLightPageState {
  const TrafficLightPageLoaded({
    required this.image,
    required this.answers,
    required this.previousImages,
  });

  final Tuple2<String, bool> image;
  final List<int> previousImages;
  final List<bool> answers;

  @override
  List<Object> get props => [image, answers, previousImages];
}

class TrafficLightPageSuccess extends TrafficLightPageState {
  @override
  List<Object?> get props => [];
}

class TrafficLightPageFail extends TrafficLightPageState {
  @override
  List<Object?> get props => [];
}
