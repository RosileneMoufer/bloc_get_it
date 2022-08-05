import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_state.dart';

class SearchCepBloc extends Bloc<String, SearchCepState> {
  final Dio _dio;

  SearchCepBloc(this._dio) : super(const SearchCepSuccess({}));

  @override
  Stream<SearchCepState> mapEventToState(String cep) async* {
    yield const SearchCepLoading();

    try {
      final response = await _dio.get('https://viacep.com.br/ws/$cep/json/');

      yield SearchCepSuccess(response.data!);
    } catch (e) {
      yield const SearchCepError("Erro na pesquisa");
    }
  }
}
