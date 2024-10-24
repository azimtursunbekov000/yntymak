import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../internal/helpers/catch_excertion.dart';
import '../../../../data/models/cities_model.dart';
import '../../../../domain/use_case/auth_use_case.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final AuthUseCase useCase;
  CityBloc(this.useCase) : super(CityInitialState()) {
    on<GetCitiesEvent>((event, emit) async {
      emit(CityLoadingState());
      try {
        CitiesModel citiesModel = await useCase.getCities();
        emit(CityLoadedState(citiesModel: citiesModel));
      } catch (e) {
        print('error fetching cities $e');
        emit(CityErrorState(error: CatchException.convertException(e)));
      }
    });
  }
}
