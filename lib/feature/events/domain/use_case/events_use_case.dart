import '../../data/models/events_model.dart';
import '../repositories/events_repository.dart';

class EventsUseCase {
  final NewsRepository newsRepository;

  EventsUseCase({required this.newsRepository});

  Future<EventsModel> getAllNews(EventsModel? newsModel) async {
    return await newsRepository.getAllNews();
  }
}
