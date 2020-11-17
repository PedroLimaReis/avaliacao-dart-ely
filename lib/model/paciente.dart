class Paciente {
  int _id;
  String _nome;
  String _idade;
  String _sexo;
  String _peso;

  Paciente(this._nome, this._idade, this._sexo, this._peso);

  Paciente.map(dynamic obj) {
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._idade = obj['idade'];
    this._sexo = obj['sexo'];
    this._peso = obj['peso'];
  }

  int get id => _id;
  String get nome => _nome;
  String get idade => _idade;
  String get sexo => _sexo;
  String get peso => _peso;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['nome'] = _nome;
    map['idade'] = _idade;
    map['sexo'] = _sexo;
    map['peso'] = _peso;
    return map;
  }

  Paciente.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nome = map['nome'];
    this._idade = map['idade'];
    this._sexo = map['sexo'];
    this._peso = map['peso'];
  }
}
