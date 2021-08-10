class Menu {
  late String name;

  Menu({required this.name});

  Menu.fromJson(Map<String, dynamic> data) {
    name = data["name"];
  }
}

List<Menu> parseMenu(List menu) {
  return menu.map((data) => Menu.fromJson(data)).toList();
}
