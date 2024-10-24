part of 'city_bloc.dart';

@immutable
sealed class CityEvent {}

class GetCitiesEvent extends CityEvent {}

