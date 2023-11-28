class Cultura {
  String nome;
  String info;
  String icone;
  

  Cultura({
    required this.info,
    required this.nome,
    required this.icone,
  });

  factory Cultura.fromMap(Map<String, dynamic> map){
    return Cultura(info: 'info',
     nome: map['nome'],
     icone: map['icone'],
     );
  }
}
