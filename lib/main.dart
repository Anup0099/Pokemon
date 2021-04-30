import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokemon/pokemon.dart';

void main() => runApp(MaterialApp(
      title: "Poke App",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url =
      "Https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  PokeHub pokeHub;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    
    var decodedJSON = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJSON);

    print(pokeHub.toJson());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("poke app"),
        backgroundColor: Colors.cyan,
      ),
      body: pokeHub == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: pokeHub.pokemon.map((poke) {
                
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  
                  child: InkWell(
                    onTap: (){},
                                      child: Card(
                      elevation: 3.0,
                      child: Column(
                        
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            //child: Image.network(poke.img),
                            height: 100.0,
                            width: 100.0,
                             decoration: BoxDecoration(
                                 image: DecorationImage(
                                     image: NetworkImage(poke.img))),
                                    
                          ),
                          Text(
                            poke.name,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.cyan,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
