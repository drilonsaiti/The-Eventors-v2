final String tableRefreshToken = 'refreshToken';

class RefreshTokenFields {
  static final List<String> values = [id, username, refreshToken];
  static final String id = "_id";
  static final String username = "username";
  static final String refreshToken = "refreshToken";
}

class RefreshToken {
  final int? id;
  final String username;
  final String refreshToken;

  const RefreshToken({
    this.id,
    required this.username,
    required this.refreshToken,
  });

  RefreshToken copy({
    int? id,
    String? username,
    String? refreshToken,
  }) =>
      RefreshToken(
        id: id ?? this.id,
        username: username ?? this.username,
        refreshToken: refreshToken ?? this.refreshToken,
      );

  Map<String, Object?> toJson() => {
        RefreshTokenFields.id: id,
        RefreshTokenFields.username: username,
        RefreshTokenFields.refreshToken: refreshToken,
      };

  static RefreshToken fromJson(Map<String, Object?> json) => RefreshToken(
        id: json[RefreshTokenFields.id] as int?,
        username: json[RefreshTokenFields.username] as String,
        refreshToken: json[RefreshTokenFields.refreshToken] as String,
      );
}
