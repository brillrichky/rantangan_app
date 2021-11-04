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
  String senin;
  String selasa;
  String rabu;
  String kamis;
  String jumat;

  Menu({
    this.senin,
    this.selasa,
    this.rabu,
    this.kamis,
    this.jumat,
  });

  Menu.fromMap(Map<String, dynamic> data) {
    senin = data["menu"]["senin"];
    print(senin);
  }
}
