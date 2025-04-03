class UserSession {
  String id;
  String name;
  String role;
  String password;
  String? email;
  String? matricula;


  UserSession({
    required this.id,
    required this.name,
    required this.role,
    required this.password,
    this.email,
    this.matricula,
  });
}