class MomentModel {
  final String id;
  final String userId;
  final String? userName;
  final String? userPhotoUrl;
  final String imageUrl;
  final String caption;
  final double latitude;
  final double longitude;
  final String? locationName;
  final String groupId;
  final DateTime createdAt;

  MomentModel({
    required this.id,
    required this.userId,
    this.userName,
    this.userPhotoUrl,
    required this.imageUrl,
    required this.caption,
    required this.latitude,
    required this.longitude,
    this.locationName,
    required this.groupId,
    required this.createdAt,
  });

  factory MomentModel.fromJson(Map<String, dynamic> json) {
    return MomentModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String?,
      userPhotoUrl: json['userPhotoUrl'] as String?,
      imageUrl: json['imageUrl'] as String,
      caption: json['caption'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      locationName: json['locationName'] as String?,
      groupId: json['groupId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userPhotoUrl': userPhotoUrl,
      'imageUrl': imageUrl,
      'caption': caption,
      'latitude': latitude,
      'longitude': longitude,
      'locationName': locationName,
      'groupId': groupId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
