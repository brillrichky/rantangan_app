class MealPlanModel {
  String id;
  String name;
  String vendorId;
  String description;
  String price;
  Menu menu;
  List<String> allergen;

  MealPlanModel({
    this.id,
    this.name,
    this.description,
    this.vendorId,
    this.menu,
    this.price,
    this.allergen,
  });

  MealPlanModel.fromMap(Map<String, dynamic> data) {
    id = data["id"];
    name = data["name"];
    description = data["description"];
    price = data["mealPrice"];
    allergen = List.from(data["allergen"]);
    menu = Menu.fromMap(data);
  }
}

class Menu {
  List<String> menuSiang;
  List<String> menuPagi;

  Menu({
    this.menuSiang,
    this.menuPagi,
  });

  Menu.fromMap(Map<String, dynamic> data) {
    menuSiang = List.from(data["menu"]["menuSiang"]);
    menuPagi = List.from(data["menu"]["menuPagi"]);
  }
}
