class FormValidator {
  static String validateEmail(String value) {
    if (value.isEmpty) return "Email required";
    if (value.length < 5)
      return 'Email should be greater than 5 characters';
    else if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value))
      return null;
    else
      return 'Enter a valid Email';
  }

  static String validateName(String value) {
    if (value.length < 3)
      return 'User name must be more than 2 charater';
    else
      return null;
  }

  static String validateMobile(String value) {
    if (value.length != 10)
      return 'Enter a Valid Number';
    else
      return null;
  }

  static String validateNumber(String value) {
    if (value == null)
      return 'Please select a number';
    else
      return null;
  }

  static String validatePassword(String value) {
    Pattern pattern = r'^[a-zA-Z0-9]+$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter password';
    } else if (value.length < 5) {
      return 'Password should be greater than 5 characters';
    } else {
      if (!regex.hasMatch(value))
        return 'Enter a valid password';
      else
        return null;
    }
  }
}
