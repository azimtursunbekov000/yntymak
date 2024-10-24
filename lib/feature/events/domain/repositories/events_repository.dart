import '../../data/models/events_model.dart';

abstract class NewsRepository {
  /// получение новостей
  ///
  Future<EventsModel> getAllNews();
}
