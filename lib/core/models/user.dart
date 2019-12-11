class User {
  String name;
  String email;
  String password;

  User({this.name, this.email, this.password});

  // TODO Reminder: Delete on production
  User.initial()
      : name = '',
        email = 'cocoataster@gmail.com',
        password = 'soundsgood';
}
