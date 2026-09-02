/// User entity in Domain layer
class UserEntity {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final String? avatarUrl;
  final bool isVerified;

  const UserEntity({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.avatarUrl,
    this.isVerified = true,
  });
}
