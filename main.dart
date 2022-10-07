import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const Home(title: 'Flutter Demo Home Page'),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

enum Tipo {PaiAus, PaiPres}

class _HomeState extends State<Home> {
  final quantidade = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Tipo _tipo = Tipo.PaiAus;

  String _result = "";

  void _refresh_inputs() {
    quantidade.text = "";
  }

  void setEstadoPai(Tipo value) {
    setState(() {
      _tipo = value;
    });
  }

  void setResult(String value){
    setState(() {
      _result = value;
    });
  }

  void calculate(){
    int quantinty = int.parse(quantidade.text);
    double bolsa = 0;

    if(_tipo == Tipo.PaiAus){
      bolsa += 600.0;
    }

    if(Dropdown.dropdownValue == "Abaixo de 1 Salário Mínimo (1212,00 reais)"){
      if(quantinty > 0 && quantinty <= 2){
        bolsa += 3030.0;
        setResult("x");
      }
    }

    else if(Dropdown.dropdownValue == "Abaixo de 2 Salários Mínimos (2424,00 reais)"){
      if(quantinty > 0 && quantinty <= 2){
        bolsa += 1818.0;
        setResult("y");
      }
      else if(quantinty >= 3){
        bolsa += 3636.0;
        setResult("z");
      }
    }

    setResult("O valor recebido será de ${bolsa} reais");
  }

  //@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cálculo de valor de bolsas"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _refresh_inputs
          ),
        ],
      ),
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Número de filhos NA ESCOLA e VACINADOS:",
                  labelStyle: TextStyle(color: Colors.deepPurple),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
                controller: quantidade,
              ),

              Dropdown(),

              ListTile(
                title: const Text("Mãe solteira"),
                leading: Radio<Tipo>(
                    value: Tipo.PaiAus,
                    groupValue: _tipo,
                    onChanged: (Tipo? value) {
                      if (value != null) setEstadoPai(value);
                    }),
              ),
              ListTile(
                title: const Text("Pai presente"),
                leading: Radio<Tipo>(
                    value: Tipo.PaiPres,
                    groupValue: _tipo,
                    onChanged: (Tipo? value) {
                      if (value != null) setEstadoPai(value);
                    }),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate())
                        calculate();
                    },
                    child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25.0),),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
                  ),
                ),
              ),

              Text("$_result")
            ],
          ),
        ),
      ),
    );
  }
}

const List<String> list = <String>["RENDA FAMILIAR: ", "Abaixo de 1 Salário Mínimo (1212,00 reais)", "Abaixo de 2 Salários Mínimos (2424,00 reais)", "2 Salários Mínimos ou mais (a partir de 2424,00 reais)"];

class Dropdown extends StatefulWidget {
  Dropdown({Key? key}) : super(key: key);
  static String dropdownValue = list.first;
  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: Dropdown.dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      underline: Container(
        height: 2,
      ),
      onChanged: (String? value) {
        setState(() {
          Dropdown.dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
