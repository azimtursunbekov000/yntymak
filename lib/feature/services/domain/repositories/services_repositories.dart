import '../../data/models/services_model.dart';

abstract class ServicesRepository {
  /// для получения всех сервисов
  Future<ServicesModel> getAllServices();
}
