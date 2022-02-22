class CharacterData {
  Characters? characters;

  CharacterData({this.characters});

  CharacterData.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      characters = json['characters'] != null
          ? Characters.fromJson(json['characters'])
          : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (characters != null) {
      data['characters'] = characters!.toJson();
    }
    return data;
  }
}

class Characters {
  Info? info;
  List<Character>? results;

  Characters({this.info, this.results});

  Characters.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    if (json['results'] != null) {
      results = <Character>[];
      json['results'].forEach((v) {
        results!.add(Character.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (info != null) {
      data['info'] = info!.toJson();
    }
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Info {
  int? pages;
  int? next;

  Info({this.pages});

  Info.fromJson(Map<String, dynamic> json) {
    pages = json['pages'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pages'] = pages;
    data['next'] = next;
    return data;
  }
}

class Character {
  String? id;
  String? name;
  String? status;
  String? species;
  String? gender;
  String? image;
  Location? location;
  Location? origin;

  Character(
      {this.id,
      this.name,
      this.status,
      this.species,
      this.gender,
      this.image,
      this.location,
      this.origin});

  Character.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    gender = json['gender'];
    image = json['image'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    origin = json['origin'] != null ? Location.fromJson(json['origin']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['species'] = species;
    data['gender'] = gender;
    data['image'] = image;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (origin != null) {
      data['origin'] = origin!.toJson();
    }
    return data;
  }
}

class Location {
  String? name;

  Location({this.name});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
