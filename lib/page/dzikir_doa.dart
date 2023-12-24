import 'dart:convert';
import 'package:belajarsholat/model/model_dzikir.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

class DzikirDoa extends StatefulWidget {
  const DzikirDoa({super.key});

  @override
  State<DzikirDoa> createState() => DzikirDoaState();
}

class DzikirDoaState extends State<DzikirDoa> {
  Future<List<ModelDzikir>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/data/doa.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => ModelDzikir.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_dzikir.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.only(top: 80),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(255, 46, 111, 165),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 211, 216, 233)
                                .withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          )
                        ]),
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                        margin: const EdgeInsets.only(top: 120, left: 20),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Dzikir dan Doa",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Bacaan Dzikir Sesudah Menunaikan Shalat",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Image.asset(
                      "assets/images/bg_doa.jpg",
                      width: 300,
                      height: 200,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                future: ReadJsonData(),
                builder: (context, data) {
                  if (data.hasError) {
                    return Center(child: Text("${data.error}"));
                  } else if (data.hasData) {
                    var items = data.data as List<ModelDzikir>;
                    return ListView.builder(
                        itemCount: items == null ? 0 : items.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 5,
                            margin: const EdgeInsets.all(15),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                title: Text(
                                  items[index].name.toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 8),
                                                child: Text(
                                                  items[index]
                                                      .arabic
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 8),
                                                child: Text(
                                                  items[index].latin.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 8, top: 5),
                                                child: Text(
                                                    items[index]
                                                        .terjemahan
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    )),
                                              )
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
