import '../../data/models/services_model.dart';
import '../repositories/services_repositories.dart';

class ServicesUseCase {
  final ServicesRepository servicesRepository;

  ServicesUseCase({required this.servicesRepository});

  Future<ServicesModel> getAllServices() async {
    return await servicesRepository.getAllServices();
  }
}
