class Customer {
  late int id;
  late String name;
  late String email;
  Customer(this.id, this.name, this.email);
  Customer.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    email = data['email'];
  }
}
