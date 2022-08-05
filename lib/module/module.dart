import 'package:bloc_get_it/bloc/search_cep_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

initModule() {
  getIt.registerFactory(() => Dio());
  getIt.registerSingleton<SearchCepBloc>(SearchCepBloc(getIt()));
}

disposeModule() {
  getIt<SearchCepBloc>().close();
  getIt.unregister<SearchCepBloc>();
  getIt.unregister<Dio>();
}
