class MenuModel {
  final int id;
  final int subUnits;
  final String title;
  final int order;
  final String displayNormal;
  final String displaySelected;
  final String timestamp;
  final List<SubMenuModel> submenus;


  MenuModel({
    required this.id,
    required this.subUnits,
    required this.title,
    required this.order,
    required this.displayNormal,
    required this.displaySelected,
    required this.timestamp,
    required this.submenus,
  });


  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      id: json['id'],
      subUnits: json['subUnits'],
      title: json['title'],
      order: json['order'],
      displayNormal: json['display_normal'],
      displaySelected: json['display_selected'],
      timestamp: json['timestamp'],
      submenus: (json['submenus'] as List)
          .map((submenuJson) => SubMenuModel.fromJson(submenuJson))
          .toList(),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subUnits': subUnits,
      'title': title,
      'order': order,
      'display_normal': displayNormal,
      'display_selected': displaySelected,
      'timestamp': timestamp,
      'submenus': submenus.map((submenu) => submenu.toJson()).toList(),
    };
  }
}

class SubMenuModel {
  final int id;
  final String title;
  final int order;

  SubMenuModel({
    required this.id,
    required this.title,
    required this.order,
  });

  factory SubMenuModel.fromJson(Map<String, dynamic> json) {
    return SubMenuModel(
      id: json['id'],
      title: json['title'],
      order: json['order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'order': order,
    };
  }
}
