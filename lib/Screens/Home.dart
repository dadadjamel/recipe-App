import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:recipeAppv2/Screens/recipeView.dart';
import 'package:recipeAppv2/models/recipe_model.dart';
import 'package:recipeAppv2/services/recipes.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String inputSearch = 'chicken';
  TextEditingController sendrecipeController = TextEditingController();
  List<RecipeClass> recipes = new List<RecipeClass>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipes();
  }

  getRecipes() async {
    RecipeService rs = RecipeService();
    await rs.fetchrecipies(inputSearch);
    recipes = rs.recipes;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple[900],
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'My',
                style: TextStyle(color: Colors.white),
              ),
              Text('Recipes', style: TextStyle(color: Colors.blue[300])),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.deepPurple[900],
        padding: EdgeInsets.only(top: 30, right: 30, left: 30),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Text('What will you cook today, Boss ?',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            SizedBox(height: 10),
            Text(
                'just enter ingredients you have and we will show you the best recipe for you',
                style: TextStyle(fontSize: 15, color: Colors.white
                    // fontWeight: FontWeight.bold
                    )),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hoverColor: Colors.white,
                          // icon: Icon(Icons.clear),
                          hintText: 'Type here your recipe',
                          hintStyle: TextStyle(color: Colors.white),
                          suffix: IconButton(
                            onPressed: () {
                              sendrecipeController.clear();
                            },
                            icon: Icon(
                              Icons.clear,
                              color: Colors.white,
                            ),
                          ),
                          suffixIcon: Icon(Icons.send, color: Colors.white)),
                      onSubmitted: (String input) {
                        inputSearch = input;
                        sendrecipeController.clear();
                        getRecipes();
                      },
                      cursorColor: Colors.white,
                      controller: sendrecipeController,
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   height: MediaQuery.of(context).size.height *0.5,
            //   width: MediaQuery.of(context).size.width *0.5,
            //   child: SpinKitCubeGrid(
            //     color: Colors.white,
            //     size: 100.0,
            //   ),
            // ),
            // Text(inputSearch),
            _loading
                ? Flexible(
                  flex: 1,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: SpinKitCubeGrid(
                        color: Colors.white,
                        size: 100.0,
                      ),
                    ),
                  )
                // : Expanded(
                //     child: Container(
                //       height: MediaQuery.of(context).size.height,
                //       margin: EdgeInsets.symmetric(vertical: 10),
                //       child: ListView.builder(
                //         shrinkWrap: true,
                //         physics: ClampingScrollPhysics(),
                //         itemCount: recipes.length,
                //         scrollDirection: Axis.vertical,
                //         itemBuilder: (context, index) {
                //           return (RecipeTile(
                //             imageURL: recipes[index].imageURL,
                //             title: recipes[index].title,
                //             url: recipes[index].url,
                //           ));
                //         },
                //       ),
                //     ),
                //   )
                // ___________________________________________________________
                : Expanded(
                                  child: GridView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisSpacing: 10
                    ),
                    children: List.generate(recipes.length, (index) {
                      return GridTile(
                        child: RecipeTile(
                        imageURL: recipes[index].imageURL,
                        title: recipes[index].title,
                        url: recipes[index].url,
                      ),
                      );
                    }),
                  ),
                )
          ],
        ),
      ),
    );
  }
}

class RecipeTile extends StatelessWidget {
  final String imageURL, title, url;
  RecipeTile({this.url, this.title, this.imageURL});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecipeDetail(
                      recipeURL: url,
                    )));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageURL,
                width: 130,
                height: 130,
              ),
            ),
            Container(
                // padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  color: Colors.white38,
                ),
                width: 130,
                height: 40,
                child: Center(child: Text(title))),
          ],
        ),
      ),
    );
  }
}
