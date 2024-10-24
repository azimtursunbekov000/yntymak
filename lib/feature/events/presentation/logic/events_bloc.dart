import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../internal/helpers/catch_excertion.dart';
import '../../data/models/events_model.dart';
import '../../domain/use_case/events_use_case.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<NewsEvent, NewsState> {
  final EventsUseCase useCase;

  EventsBloc(this.useCase) : super(NewsInitialState()) {
    on<GetNewsEvent>((event, emit) async {
      emit(NewsLoadingState());
      try {
        EventsModel newsModel = await useCase.getAllNews(event.newsModel);
        emit(NewsLoadedState(newsModel: newsModel));
        print('News loaded: ${newsModel.results}');
      } catch (e) {
        print('ошибка при стягивании новостей $e');
        emit(NewsErrorState(error: CatchException.convertException(e)));
      }
    });
  }
}
