class User {
  String name;
  String email;
  String password;

  User({this.name, this.email, this.password});

  User.initial()
      : name = '',
        email = 'alb.garciam@gmail.com',
        password = '1234567';
// TODO Clean on production


}
