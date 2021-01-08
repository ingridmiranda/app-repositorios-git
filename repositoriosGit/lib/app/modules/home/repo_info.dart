import 'dart:convert';

import 'package:repositoriosGit/app/modules/home/user_info.dart';

class RepoInfo {
  int id;
  String name;
  String full_name;
  UserInfo owner;
  String html_url;
  String description;
  String url;
  
  RepoInfo({
    this.id,
    this.name,
    this.full_name,
    this.owner,
    this.html_url,
    this.description,
    this.url,
  });

  RepoInfo copyWith({
    int id,
    String name,
    String full_name,
    UserInfo owner,
    String html_url,
    String description,
    String url,
  }) {
    return RepoInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      full_name: full_name ?? this.full_name,
      owner: owner ?? this.owner,
      html_url: html_url ?? this.html_url,
      description: description ?? this.description,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'full_name': full_name,
      'owner': owner?.toMap(),
      'html_url': html_url,
      'description': description,
      'url': url,
    };
  }

  factory RepoInfo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return RepoInfo(
      id: map['id'],
      name: map['name'],
      full_name: map['full_name'],
      owner: UserInfo.fromMap(map['owner']),
      html_url: map['html_url'],
      description: map['description'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RepoInfo.fromJson(String source) => RepoInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RepoInfo(id: $id, name: $name, full_name: $full_name, owner: $owner, html_url: $html_url, description: $description, url: $url)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is RepoInfo &&
      o.id == id &&
      o.name == name &&
      o.full_name == full_name &&
      o.owner == owner &&
      o.html_url == html_url &&
      o.description == description &&
      o.url == url;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      full_name.hashCode ^
      owner.hashCode ^
      html_url.hashCode ^
      description.hashCode ^
      url.hashCode;
  }
}
