import 'dart:convert';

class UserInfo {
  String login;
  int id;
  String avatar_url;
  String url;
  String html_url;
  
  UserInfo({
    this.login,
    this.id,
    this.avatar_url,
    this.url,
    this.html_url,
  });

  UserInfo copyWith({
    String login,
    int id,
    String avatar_url,
    String url,
    String html_url,
  }) {
    return UserInfo(
      login: login ?? this.login,
      id: id ?? this.id,
      avatar_url: avatar_url ?? this.avatar_url,
      url: url ?? this.url,
      html_url: html_url ?? this.html_url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'id': id,
      'avatar_url': avatar_url,
      'url': url,
      'html_url': html_url,
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return UserInfo(
      login: map['login'],
      id: map['id'],
      avatar_url: map['avatar_url'],
      url: map['url'],
      html_url: map['html_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfo.fromJson(String source) => UserInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserInfo(login: $login, id: $id, avatar_url: $avatar_url, url: $url, html_url: $html_url)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is UserInfo &&
      o.login == login &&
      o.id == id &&
      o.avatar_url == avatar_url &&
      o.url == url &&
      o.html_url == html_url;
  }

  @override
  int get hashCode {
    return login.hashCode ^
      id.hashCode ^
      avatar_url.hashCode ^
      url.hashCode ^
      html_url.hashCode;
  }
}


 