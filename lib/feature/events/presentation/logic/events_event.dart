part of 'events_bloc.dart';

@immutable
sealed class NewsEvent {}

class GetNewsEvent extends NewsEvent {
  final EventsModel? newsModel;

  GetNewsEvent({required this.newsModel});
}
