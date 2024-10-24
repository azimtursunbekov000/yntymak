class ServicesModel {
  final int? id;
  final String? name;
  final String? apiUrl;
  final String? icon;

  ServicesModel({
    this.id,
    this.name,
    this.apiUrl,
    this.icon,
  });

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    return ServicesModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      apiUrl: json['api_url'] as String?,
      icon: json['icon'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'api_url': apiUrl,
      'icon': icon,
    };
  }
}
