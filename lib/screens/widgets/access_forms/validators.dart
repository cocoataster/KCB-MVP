 String nameValidator({value, errorMessage}) {
    if (value.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  String emailValidator({value, errorMessage}) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return errorMessage;
    else
      return null;
  }

  String passwdValidator({value, errorMessage}) {
    if (value.isEmpty) {
      return errorMessage;
    }
    return null;
  }