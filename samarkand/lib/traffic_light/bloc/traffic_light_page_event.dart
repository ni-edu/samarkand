part of 'traffic_light_page_bloc.dart';

abstract class TrafficLightPageEvent extends Equatable {
  const TrafficLightPageEvent();
}

class TrafficLightPageInit extends TrafficLightPageEvent {
  @override
  List<Object?> get props => [];
}

class TrafficLightPageNextImage extends TrafficLightPageEvent {
  const TrafficLightPageNextImage({required this.answer});

  final bool answer;

  @override
  List<Object?> get props => [answer];
}
