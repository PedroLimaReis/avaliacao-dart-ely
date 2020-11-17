import 'package:flutter/material.dart';
import '../model/paciente.dart';
import '../db/database_helper.dart';
import 'paciente_screen.dart';

class ListViewPaciente extends StatefulWidget {
  @override
  _ListViewPacienteState createState() => new _ListViewPacienteState();
}

class _ListViewPacienteState extends State<ListViewPaciente> {
  List<Paciente> items = new List();

  DatabaseHelper db = new DatabaseHelper();
  @override
  void initState() {
    super.initState();
    db.getAllPacientes().then((pacientes) {
      setState(() {
        pacientes.forEach((paciente) {
          items.add(Paciente.fromMap(paciente));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cadastro de Paciente'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Column(
                  children: [
                    Divider(height: 5.0),
                    ListTile(
                      title: Text(
                        '${items[position].nome}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Row(children: [
                        Text(
                            '${items[position].idade} (${items[position].sexo}) (${items[position].peso})',
                            style: new TextStyle(
                              fontSize: 18.0,
                              fontStyle: FontStyle.italic,
                            )),
                        IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            color: Colors.red,
                            onPressed: () => _deletePaciente(
                                context, items[position], position)),
                      ]),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 15.0,
                        child: Text(
                          '${items[position].id}',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      onTap: () =>
                          _navigateToPaciente(context, items[position]),
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewPaciente(context),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }

  void _deletePaciente(
      BuildContext context, Paciente paciente, int position) async {
    db.deletePaciente(paciente.id).then((pacientes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToPaciente(BuildContext context, Paciente paciente) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PacienteScreen(paciente)),
    );
    if (result == 'update') {
      db.getAllPacientes().then((pacientes) {
        setState(() {
          items.clear();
          pacientes.forEach((paciente) {
            items.add(Paciente.fromMap(paciente));
          });
        });
      });
    }
  }

  void _createNewPaciente(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PacienteScreen(Paciente('', '', '', ''))),
    );

    if (result == 'save') {
      db.getAllPacientes().then((pacientes) {
        setState(() {
          items.clear();
          pacientes.forEach((paciente) {
            items.add(Paciente.fromMap(paciente));
          });
        });
      });
    }
  }
}
