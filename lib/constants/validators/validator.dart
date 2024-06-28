class Validator {

   static String? validatePhoneNumber(String value) {
     String pattern = r'^(?:0[5-7])\d{8}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter a phone number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
  static String? validateAddress(String value) {
    if (value.isEmpty) {
      return 'Please enter an address';
    } else if (value.length < 5) {
      return 'Address is too short';
    }
    return null;
  }
  static String? validateCIN(String value) {
    String pattern = r'^[A-Z]{2}\d{6}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter a CIN';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid Moroccan CIN';
    }
    return null;
  }
}