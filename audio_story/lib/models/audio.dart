class Audio {
  final String name;
  final String url;

  const Audio({
    required this.name,
    required this.url,
  });

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        name: json['name'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
      };
}