class AudioModel {
  final String name;
  final String url;

  const AudioModel({
    required this.name,
    required this.url,
  });

  factory AudioModel.fromJson(Map<String, dynamic> json) => AudioModel(
        name: json['name'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
      };
}