class GroupModel {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final List<String> memberIds;
  final String createdBy;

  GroupModel({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.memberIds,
    required this.createdBy,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
      memberIds: List<String>.from(json['memberIds'] as List),
      createdBy: json['createdBy'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'memberIds': memberIds,
      'createdBy': createdBy,
    };
  }
}
