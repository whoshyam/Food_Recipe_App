import 'dart:convert';
import 'dart:developer';
import 'package:food_idea/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:food_idea/search.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  List<ReciepeModel> reciepeList = <ReciepeModel>[];
  TextEditingController searchController = new TextEditingController();

  getRecipe(String query) async {
    setState(() { });
    String url =
        "https://api.edamam.com/search?q=$query&app_id=d90bc71b&app_key=aae561ebc75589afa66c9bca6e0ac86f";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);

    setState(() {
      data["hits"].forEach((element) {
        ReciepeModel reciepeModel = new ReciepeModel();
        reciepeModel = ReciepeModel.fromMap(element["recipe"]);
        reciepeList.add(reciepeModel);
        setState(() {
          isLoading = false;
        });
      });
    });

    // reciepeList.forEach((element) {
    //   print(element.applabel);
    //   print(element.appcalories);
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipe("Ladoo");
  }


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xff213A50),
                Color(0xff071938),
              ]),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if ((searchController.text).replaceAll(" ", "") ==
                                "") {
                              print("Blank search");
                            } else {

                                Navigator.push(context, MaterialPageRoute(builder: (context) => Search(searchController.text)));


                            }
                          },
                          child: Container(
                            child: Icon(
                              Icons.search,
                            ),
                            margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Let's Cook Something!"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "WHAT DO YOU WANT TO COOK TODAY?",
                        style: TextStyle(fontSize: 33, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Let's Cook Something New!", style: TextStyle(fontSize: 20,color: Colors.white),)
                    ],
                  ),
                ),
                Container(
                  child: isLoading ? CircularProgressIndicator() : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: reciepeList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Card(
                            margin: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0.0,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    reciepeList[index].appimageurl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 250,
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  bottom: 0,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    color: Colors.black,
                                    child: Text(
                                      reciepeList[index].applabel,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                // Positioned(
                                //   right: 0,
                                //   child: Container(
                                //     color: Colors.white,
                                //     child: Text(reciepeList[index].appcalories.toString().substring(0,5)),
                                //   ),)
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
