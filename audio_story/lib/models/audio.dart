class AudioModel {
  final String name;
  final String url;
  final String id;

  const AudioModel({
    required this.name,
    required this.url,
    required this.id,
  });

  factory AudioModel.fromJson(Map<String, dynamic> json) => AudioModel(
        name: json['name'],
        url: json['url'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
        'id': id,
      };
}

