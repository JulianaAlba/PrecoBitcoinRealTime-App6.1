import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class BitcoinAvancado extends StatefulWidget {
  @override
  _BitcoinAvancadoState createState() => _BitcoinAvancadoState();
}

class _BitcoinAvancadoState extends State<BitcoinAvancado> {

  //Future = dados futuros
  Future<Map> _recuparPrecoBitcoin() async {
    String url = "https://blockchain.info/ticker";
    http.Response respostaEnderecoURL = await http.get(url);
    return json.decode(respostaEnderecoURL.body);


  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Map>(
      future: _recuparPrecoBitcoin(),

      builder: (context, snapshot){
        //declarando variáveis
        double _precoBitcoin = 0.0;
        String resultadoConexaoFuture = "";

        switch( snapshot.connectionState ){
          case ConnectionState.none :
            print("conexao none");
            resultadoConexaoFuture = "Nenhuma Conexão";
            break;

          case ConnectionState.waiting :
            print("conexao waiting");
            resultadoConexaoFuture = "Carregando...";
            break;

          case ConnectionState.active :
            print("conexao active");
            resultadoConexaoFuture = "Ativa...";
            break;

          case ConnectionState.done :
            print("conexao done");
            if( snapshot.hasError ){
              resultadoConexaoFuture = "Mal Sucedida! Erro ao carregar os dados!";
            }
            else {
              _precoBitcoin = snapshot.data["BRL"]["buy"];
              resultadoConexaoFuture = "Bem Sucedida!";

              print(_precoBitcoin);
              print(resultadoConexaoFuture);
              //resultadoConexaoFuture = "Preço do bitcoin: ${_precoBitcoin.toString()} ";
            }
            break;
        }

        return Scaffold(
          backgroundColor: Colors.tealAccent,

          body: Center(
            child: SingleChildScrollView(
              child: Container(
                child: Column(

                  children: <Widget>[
                    Image.asset("imagens/bitcoin.png"),

                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                          children: <Widget>[
                            Text("R\$ ${_precoBitcoin}",
                                style: TextStyle(
                                  //color: Colors.white,
                                  fontSize: 25,
                                  //backgroundColor: Colors.orange,
                                )
                            ),

                            Text("Conexão ${resultadoConexaoFuture}",
                                style: TextStyle(
                                  //color: Colors.white,
                                  fontSize: 25,
                                  //backgroundColor: Colors.orange,
                                )
                            ),

                          ]
                      ),
                    ),

                    /*RaisedButton(
                      color: Colors.orange,
                      padding: EdgeInsets.fromLTRB(25, 15, 25, 15),

                      child: Text("Atualizar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          //backgroundColor: Colors.orange,
                        )
                      ),

                      onPressed: _recuparPrecoBitcoin,

                    ),*/

                  ],
                ),
              ),
            ),
          ),
        );


      },
    );


  }
}
