class User {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final String? dob;
  final String? gender;
  final String? course;
  final String? createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.dob,
    this.gender,
    this.course,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      dob: json['dob'],
      gender: json['gender'],
      course: json['course'],
      createdAt: json['created_at'],
    );
  }
}