import 'package:flutter/material.dart';
import '../model/paciente.dart';
import '../db/database_helper.dart';

class PacienteScreen extends StatefulWidget {
  final Paciente paciente;
  PacienteScreen(this.paciente);
  @override
  State<StatefulWidget> createState() => new _PacienteScreenState();
}

class _PacienteScreenState extends State<PacienteScreen> {
  DatabaseHelper db = new DatabaseHelper();
  TextEditingController _nomeController;
  TextEditingController _idadeController;
  TextEditingController _sexoController;
  TextEditingController _pesoController;
  @override
  void initState() {
    super.initState();
    _nomeController = new TextEditingController(text: widget.paciente.nome);
    _idadeController = new TextEditingController(text: widget.paciente.idade);
    _sexoController = new TextEditingController(text: widget.paciente.sexo);
    _pesoController = new TextEditingController(text: widget.paciente.peso);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar/Editar Paciente'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            Image.network(
              'https://marcelascarpa.com.br/wp-content/uploads/2016/05/albert-einstein-hospital-logo-BD2D0B41B7-seeklogo.com_-300x230.png',
              width: 400,
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome do Paciente'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _idadeController,
              decoration: InputDecoration(labelText: 'Idade do Paciente'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _sexoController,
              decoration: InputDecoration(labelText: 'Sexo do Paciente'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _pesoController,
              decoration: InputDecoration(labelText: 'Peso do Paciente'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.paciente.id != null)
                  ? Text('Alterar')
                  : Text('Inserir'),
              onPressed: () {
                if (widget.paciente.id != null) {
                  db
                      .updatePaciente(Paciente.fromMap({
                    'id': widget.paciente.id,
                    'nome': _nomeController.text,
                    'idade': _idadeController.text,
                    'sexo': _sexoController.text,
                    'peso': _pesoController.text,
                  }))
                      .then((_) {
                    Navigator.pop(context, 'update');
                  });
                } else {
                  db
                      .insertOnePaciente(Paciente(
                          _nomeController.text,
                          _idadeController.text,
                          _sexoController.text,
                          _pesoController.text))
                      .then((_) {
                    Navigator.pop(context, 'save');
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
