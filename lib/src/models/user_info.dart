class UserInfo {
    UserInfo({
        this.id,
        this.username,
        this.name,
        this.firstName = '',
        this.lastName = '',
        this.email = '',
        this.url = '',
        this.description = '',
        this.link = '',
        this.locale = '',
        this.nickname = '',
        this.slug = '',
        this.roles = const [],
        this.registeredDate,
        this.avatarUrls,
    });

    int id;
    String username;
    String name;
    String firstName;
    String lastName;
    String email;
    String url;
    String description;
    String link;
    String locale;
    String nickname;
    String slug;
    List<String> roles;
    DateTime registeredDate;
    Map<String, String> avatarUrls;

    factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        url: json["url"],
        description: json["description"],
        link: json["link"],
        locale: json["locale"], 
        nickname: json["nickname"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "url": url,
        "description": description,
        "link": link,
        "locale": locale,
        "nickname": nickname,
        "slug": slug,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "registered_date": registeredDate.toIso8601String(),
        "avatar_urls": Map.from(avatarUrls).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };

  @override
  String toString() => '{ id: ${this.id}, first_name: ${this.firstName}, last_name: ${this.lastName}, }';
}