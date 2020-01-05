class User {
  String name;
  String email;
  String password;

  User({this.name, this.email, this.password});

  User.initial()
      : name = '',
        email = 'gabriel@lagoblasco.es',
        password = '123456';
}
