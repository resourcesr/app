String sapValidator(String value) {
  if (value.isEmpty) return "Sap should not be empty";
  var regx = RegExp("^[0-9]{4,6}\$");
  return regx.hasMatch(value) ? null : "SAP much be 4 to 6 digit long";
}

String nameValidator(String value) {
  if (value.isEmpty) return "Name Field should not be empty";
  return value.split(" ").toList().length > 2
      ? null
      : "Please provide your first and last name";
}

String emailValidator(String value) {
  if (value.isEmpty) return "Email field should not be empty";
  var regx = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  return regx.hasMatch(value) ? null : "Please provide valid email";
}

String passwordValidatorl(String value) {
  if (value.isEmpty) return "Password field should not be empty";
  var regx = RegExp("^[A-Za-z0-9]{6,}\$");
  return regx.hasMatch(value) ? null : "Password much be 6 digit or greater";
}
