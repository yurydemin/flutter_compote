class PublicData {
  final String uuid;
  final String name;
  final String poster;

  PublicData({this.uuid, this.name, this.poster});

  PublicData.fromJson(Map<String, dynamic> json)
      : this(
          uuid: json['uuid'],
          name: json['name'],
          poster: json['poster'],
        );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'uuid': this.uuid,
        'name': this.name,
        'poster': this.poster,
      };
}
