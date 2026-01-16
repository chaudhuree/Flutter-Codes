// Define a model for the User
class User {
  final int? id;
  final String name;
  final String email;

  User({this.id, required this.name, required this.email});

  // Convert a User object into a Map so it can be inserted into the database
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email};
  }

  // Convert a Map into a User object
  factory User.fromMap(Map<String, dynamic> map) {
    return User(id: map['id'], name: map['name'], email: map['email']);
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email}';
  }
}
