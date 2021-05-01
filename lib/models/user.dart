import 'package:cooknotes/models/article.dart';
import 'package:cooknotes/models/recipe.dart';

class User {
  String id;
  String username;
  String profilePic;
  String displayName;
  String usertype;
  int age;
  String email;
  String password;

  List<Recipe> recipe;
  List<Article> article;

  User({
    this.id,
    this.username,
    this.profilePic,
    this.displayName,
    this.usertype,
    this.age,
    this.email,
    this.password,
    this.recipe,
    this.article,
  });

  User.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          username: json['username'],
          profilePic: json['profilePic'],
          displayName: json['displayName'],
          usertype: json['usertype'],
          age: json['age'],
          email: json['email'],
          password: json['password'],
          recipe: (json['recipe'] as List)
              .map((itemJson) => Recipe.fromJson(itemJson))
              .toList(),
          article: (json['article'] as List)
              .map((itemJson) => Article.fromJson(itemJson))
              .toList(),
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'profilePic': profilePic,
        'displayName': displayName,
        'usertype': usertype,
        'age': age,
        'email': email,
        'password': password,
        'recipe': recipe,
        'article': article,
      };
}
