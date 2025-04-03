import 'package:app_tarefas/src/model/todo.dart';
import 'package:app_tarefas/src/widgets/task_checkbox.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.alternarTema,
    required this.darkMode,
  });

  final VoidCallback alternarTema;
  final bool darkMode;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ToDo> tarefas = []; // Lista começa vazia
  List<ToDo> _filtrarNota = [];

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  // firestore

  // final FirestoreService _firestoreService = FirestoreService();
  late String _userId;

  /* @override
  void initState() {
    super.initState();
    _carregarUser();  
  } */

  @override
  void initState() {
    super.initState();
    _filtrarNota = tarefas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: appBarMethod(context),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              children: [
                buscarNota(),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Tarefas',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                if (tarefas.where((todo) => !todo.checkbox).isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Center(
                      child: Text(
                        'Nenhuma tarefa encontrada.',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                Column(
                  children: [
                    for (var todo in tarefas.where((todo) => !todo.checkbox))
                      TaskCheckbox(
                        todo: todo,
                        completarTarefa: completarTarefa,
                        excluirTarefa: excluirTarefa,
                        editarTarefa: editarTarefa,
                      ),
                  ],
                ),
                if (tarefas.where((todo) => todo.checkbox).isNotEmpty) ...[
                  const Divider(color: Colors.grey),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tarefas Concluídas',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
                Column(
                  children: [
                    for (var todo in tarefas.where((todo) => todo.checkbox))
                      TaskCheckbox(
                        todo: todo,
                        completarTarefa: completarTarefa,
                        excluirTarefa: excluirTarefa,
                        editarTarefa: editarTarefa,
                      ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 15, right: 15, left: 10),
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  _addNota();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: const Size(50, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Icon(
                  Icons.add,
                  size: 28,
                  color:
                      Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* void _carregarUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userId = user.uid;
      });

      // tarefas do firestore em tempo real 
      _firestoreService.getTodos(_userId).listen((todos) {
        setState(() {
          tarefas = todos;
          _filtrarNota = todos;
        });
      });
    }
  } */

  void completarTarefa(ToDo todo) {
    setState(() {
      todo.checkbox = !todo.checkbox;
    });
  }

  void excluirTarefa(String id) {
    setState(() {
      tarefas.removeWhere((tarefa) => tarefa.id == id);
    });
  }

  void editarTarefa(ToDo todo) {
    // dialogoEdit
  }

  void filtrarNota(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        tarefas = _filtrarNota; // recupera a lista se o campo estiver vazio
      } else {
        tarefas =
            _filtrarNota
                .where(
                  (todo) =>
                      todo.titulo.toLowerCase().contains(
                        keyword.toLowerCase(),
                      ) ||
                      todo.descricao!.toLowerCase().contains(
                        keyword.toLowerCase(),
                      ),
                )
                .toList();
      }
    });
  }

  void _addNota() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Adicionar Nota'),
              content: Container(
                constraints: const BoxConstraints(maxHeight: 300),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _tituloController,
                        decoration: const InputDecoration(labelText: 'Título'),
                        maxLength: 80,
                        maxLines: null, // poderá ocupar várias linhas
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _descricaoController,
                        decoration: const InputDecoration(
                          labelText: 'Descrição (opcional)',
                        ),
                        maxLength: 80,
                        maxLines: null,
                      ),
                      if (_tituloController.text.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'O Título não pode ser vazio!',
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close, color: Colors.purple),
                      iconSize: 22,
                    ),
                    IconButton(
                      onPressed: () {
                        if (_tituloController.text.isEmpty) {
                          setState(
                            () {},
                          ); // atualiza o estado para mostrar o erro
                          return;
                        }
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.save, color: Colors.purple),
                      iconSize: 22,
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  AppBar appBarMethod(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Text(
                'ToDo App',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              widget.darkMode ? Icons.nightlight_round : Icons.wb_sunny,
            ),
            onPressed: widget.alternarTema,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.logout,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buscarNota() {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: filtrarNota,
        style: const TextStyle(color: Colors.grey),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 25),
          prefixIconConstraints: const BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: "Pesquisar",
          hintStyle: TextStyle(color: Colors.grey[700]),
        ),
      ),
    );
  }
}
