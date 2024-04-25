import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarefas"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<Counter>(
              builder: (context, counter, child) {
                return ListView.builder(
                  itemCount: counter.count,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(counter.tarefas[index]),
                      onDismissed: (direction) {
                        counter.removeTarefa(index);
                      },
                      background: Container(
                        color: Colors.red,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.delete),
                        ),
                      ),
                      child: ListTile(
                        title: Text(counter.tarefas[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              onSubmitted: (value) {
                Provider.of<Counter>(context, listen: false)
                    .adicionarTarefa(value);
              },
              decoration: InputDecoration(
                hintText: 'Adicionar tarefa',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Counter with ChangeNotifier {
  List<String> _tarefas = [];

  List<String> get tarefas => _tarefas;

  int get count => _tarefas.length;

  void adicionarTarefa(String tarefa) {
    _tarefas.add(tarefa);
    notifyListeners();
  }

  void removeTarefa(int index) {
    _tarefas.removeAt(index);
    notifyListeners();
  }
}

git checkout -b feature_provider
git add .
git commit -m "Refatorando para usar Provider como técnica de gerenciamento de estado"
git push origin feature_provider