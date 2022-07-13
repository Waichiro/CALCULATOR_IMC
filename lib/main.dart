import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _textInformation = 'Informe seus dados';

  void _resetField(){
    weightController.text = '';
    heightController.text = '';
    setState((){
      _textInformation = 'Informe seus dados';
      _formKey = GlobalKey<FormState>();
    });

  }

  void _calculate(){
    setState((){
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);

      if(imc < 18.6){
          _textInformation = 'Abaixo do peso (${imc.toStringAsPrecision(3)})';
      }else if(imc >= 18.6 && imc < 24.9){
        _textInformation = 'Peso Ideal (${imc.toStringAsPrecision(3)})';
      }else if(imc >= 24.9 && imc < 29.9){
        _textInformation = 'Levemente Acima do Peso (${imc.toStringAsPrecision(3)})';
      }else if(imc >= 29.9 && imc < 34.9){
        _textInformation = 'Obesidade Grau I (${imc.toStringAsPrecision(3)})';
      }else if(imc >= 34.9 && imc < 39.9){
        _textInformation = 'Obesidade Grau II (${imc.toStringAsPrecision(3)})';
      }else if(imc >= 40){
        _textInformation = 'Obesidade Grau III (${imc.toStringAsPrecision(3)})';
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: _resetField,
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Peso em (Kg)",
                    labelStyle: TextStyle(
                      color: Colors.green,
                    )),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
                validator: (value) {
                  if(value!.isEmpty){
                    return "Insira Seu Peso!";
                  }
                },
                controller: weightController,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Altura em (Cm)",
                    labelStyle: TextStyle(
                      color: Colors.green,
                    )),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
                validator: (value) {
                  if(value!.isEmpty){
                    return "Insira Sua Altura!";
                  }
                },
                controller: heightController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _calculate();
                      }
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    child: const Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
              Text(
                _textInformation,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
              )
            ],
          ),
        ),
      ),
    );
  }
}
