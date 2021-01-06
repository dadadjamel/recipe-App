import 'dart:convert';

import 'package:recipeAppv2/models/recipe_model.dart';
import 'package:http/http.dart' as http;

class RecipeService {
  List<RecipeClass> recipes = [];

  Future<void> fetchrecipies(String input) async {
    String url =
        'https://api.edamam.com/search?q=${input}&app_id=ee7eadb3&app_key=';
    var response = await http.get(url).catchError((err) => print(err));
    var jsonData = jsonDecode(response.body);

    jsonData['hits'].forEach((recipe) {
      // print(recipe['recipe']['image']);
      RecipeClass recipeModel = RecipeClass(
        title: recipe['recipe']['label'],
        url: recipe['recipe']['url'],
        imageURL: recipe['recipe']['image'],
      );
      recipes.add(recipeModel);
    });
  }
}
