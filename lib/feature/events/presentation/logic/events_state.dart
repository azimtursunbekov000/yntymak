part of 'events_bloc.dart';

@immutable
sealed class NewsState {}

final class NewsInitialState extends NewsState {}

final class NewsLoadingState extends NewsState {}

final class NewsLoadedState extends NewsState {
  final EventsModel newsModel;

  NewsLoadedState({required this.newsModel});
}

final class NewsErrorState extends NewsState {
  final CatchException error;

  NewsErrorState({required this.error});
}
