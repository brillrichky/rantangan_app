class MealPlanModel {
  String id;
  String name;
  String vendorId;
  Menu menu;
  List<String> allergen;

  MealPlanModel({
    this.id,
    this.name,
    this.vendorId,
    this.menu,
    this.allergen,
  });

  MealPlanModel.fromMap(Map<String, dynamic> data) {
    id = data["id"];
    name = data["name"];
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
