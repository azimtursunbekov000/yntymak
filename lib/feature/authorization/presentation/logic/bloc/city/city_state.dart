part of 'city_bloc.dart';

@immutable
sealed class CityState {}

final class CityInitialState extends CityState {}

final class CityLoadingState extends CityState {}

final class CityLoadedState extends CityState {
  final CitiesModel citiesModel;

  CityLoadedState({required this.citiesModel});
}

final class CityErrorState extends CityState {
  final CatchException error;

  CityErrorState({required this.error});
}
