import 'package:bloc_get_it/bloc/search_cep_bloc.dart';
import 'package:bloc_get_it/bloc/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'cep',
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: () {
                GetIt.I<SearchCepBloc>().add(textController.text);
              },
              child: const Text('Pesquisar'),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<SearchCepBloc, SearchCepState>(
                bloc: GetIt.I<SearchCepBloc>(),
                builder: (context, state) {
                  if (state is SearchCepError) {
                    return Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    );
                  }

                  if (state is SearchCepLoading) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  state = state as SearchCepSuccess;

                  if (state.data.isEmpty) {
                    return const Center(child: Text("Nada foi encontrado."));
                  }

                  return Text("Cidade: ${state.data['localidade']}");
                }),
          ],
        ),
      ),
    );
  }
}
