class UserModel {
  final String refreshToken;
  final String accessToken;
  final int id;
  final String email;
  final String username;
  final String? affiliateLink;
  final bool isPaid;
  final String? token;
  final String? sentBy;
  final Level level;
  final Plan plan;
  final String timestamp;
  final String stripeCustomerId;
  final String stripeSubscriptionId;
  final String? avatar;

  UserModel({
    required this.refreshToken,
    required this.accessToken,
    required this.id,
    required this.email,
    required this.username,
    this.affiliateLink,
    required this.isPaid,
    this.token,
    this.sentBy,
    required this.level,
    required this.plan,
    required this.timestamp,
    required this.stripeCustomerId,
    required this.stripeSubscriptionId,
    this.avatar,
  });

  // Factory method to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      refreshToken: json['refresh'],
      accessToken: json['access'],
      id: json['id'],
      email: json['email'],
      username: json['username'],
      affiliateLink: json['affiliateLink'],
      isPaid: json['isPaid'],
      token: json['token'],
      sentBy: json['sentBy'],
      level: Level.fromJson(json['level']),
      plan: Plan.fromJson(json['plan']),
      timestamp: json['timestamp'],
      stripeCustomerId: json['stripeCustomerId'],
      stripeSubscriptionId: json['stripeSubscriptionId'],
      avatar: json['avatar'],
    );
  }

  // Method to convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'refresh': refreshToken,
      'access': accessToken,
      'id': id,
      'email': email,
      'username': username,
      'affiliateLink': affiliateLink,
      'isPaid': isPaid,
      'token': token,
      'sentBy': sentBy,
      'level': level.toJson(),
      'plan': plan.toJson(),
      'timestamp': timestamp,
      'stripeCustomerId': stripeCustomerId,
      'stripeSubscriptionId': stripeSubscriptionId,
      'avatar': avatar,
    };
  }
}

class Level {
  final int id;
  final String title;
  final int order;
  final String displayNormal;
  final String displaySelected;
  final String timestamp;

  Level({
    required this.id,
    required this.title,
    required this.order,
    required this.displayNormal,
    required this.displaySelected,
    required this.timestamp,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      id: json['id'],
      title: json['title'],
      order: json['order'],
      displayNormal: json['display_normal'],
      displaySelected: json['display_selected'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'order': order,
      'display_normal': displayNormal,
      'display_selected': displaySelected,
      'timestamp': timestamp,
    };
  }
}

class Plan {
  final int id;
  final String title;
  final String tagline;
  final int order;
  final double price;
  final String currencyUnit;
  final String type;
  final String extraInfo;
  final String level;
  final String timestamp;

  Plan({
    required this.id,
    required this.title,
    required this.tagline,
    required this.order,
    required this.price,
    required this.currencyUnit,
    required this.type,
    required this.extraInfo,
    required this.level,
    required this.timestamp,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'],
      title: json['title'],
      tagline: json['tagline'],
      order: json['order'],
      price: (json['price'] as num).toDouble(),
      currencyUnit: json['currencyUnit'],
      type: json['type'],
      extraInfo: json['extraInfo'],
      level: json['level'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'tagline': tagline,
      'order': order,
      'price': price,
      'currencyUnit': currencyUnit,
      'type': type,
      'extraInfo': extraInfo,
      'level': level,
      'timestamp': timestamp,
    };
  }
}
