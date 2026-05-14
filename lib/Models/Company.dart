class Company {
  int id;
  String name;
  String icon;
  String category;
  double lon;
  double lat;
  String email;
  String address;
  String phone;
  String webPage;

  Company({
    required this.id,
    required this.category ,
    required this.name,
    required this.icon,
    required this.address,
    required this.phone,
    required this.webPage,
    required this.lon,
    required this.lat ,
    required this.email
  });


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon,
      'category': category,
      'address': address,
      'phone': phone,
      'webPage': webPage,
      'lon': lon,
      'lat': lat ,
      'email': email
    };
  }

  // convert Map from database to Company
  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['id'],
      name:   map['name'],
      icon:    map['icon'],
      category:    map['category'],
      address: map['address'],
      phone:   map['phone'],
      webPage: map['webPage'],
        lon: map['lon'] as double,
        lat: map['lat'] as double,
        email: map['email']
    );
  }
}