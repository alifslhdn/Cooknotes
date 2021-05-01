class Recipe {
  String foodName;
  String image;
  int prepHours;
  int prepMins;
  int cookHours;
  int cookMins;
  int numPerson;
  String ingredients;
  String instruction;

  Recipe(
      {this.foodName,
      this.image,
      this.prepHours,
      this.prepMins,
      this.cookHours,
      this.cookMins,
      this.numPerson,
      this.ingredients,
      this.instruction});

  Recipe.copy(Recipe from)
      : this(
          foodName: from.foodName,
          image: from.image,
          prepHours: from.prepHours,
          prepMins: from.prepMins,
          cookHours: from.cookHours,
          cookMins: from.cookMins,
          numPerson: from.numPerson,
          ingredients: from.ingredients,
          instruction: from.instruction,
        );

  Recipe.fromJson(Map<String, dynamic> json)
      : this(
            foodName: json['foodName'],
            image: json['image'],
            prepHours: json['prepHours'],
            prepMins: json['prepMins'],
            cookHours: json['cookHours'],
            cookMins: json['cookMins'],
            numPerson: json['numPerson'],
            ingredients: json['ingredients'],
            instruction: json['instruction']);

  Map<String, dynamic> toJson() => {
        'foodName': foodName,
        'image': image,
        'prepHours': prepHours,
        'prepMins': prepMins,
        'cookHours': cookHours,
        'cookMins': cookMins,
        'numPerson': numPerson,
        'ingredients': ingredients,
        'instruction': instruction
      };
}
