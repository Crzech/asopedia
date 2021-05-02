class User {
  User({
      this.token,
      this.userEmail,
      this.userNicename,
      this.userDisplayName,
  });

  String token;
  String userEmail;
  String userNicename;
  String userDisplayName;

  factory User.fromJson(Map<String, dynamic> json) => User(
      token: json["token"],
      userEmail: json["user_email"],
      userNicename: json["user_nicename"],
      userDisplayName: json["user_display_name"],
  );

  Map<String, dynamic> toJson() => {
      "token": token,
      "user_email": userEmail,
      "user_nicename": userNicename,
      "user_display_name": userDisplayName,
  };
  
  @override
  String toString() {
    return "{token: $token, userEmail: $userEmail, userNiceName: $userNicename, userDisplayName: $userDisplayName}";
  }
}