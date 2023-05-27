class ValidationHelper {
  String? validateUserName(String value) {
    if (value.length < 4) {
      return "Username must be more than 4 characters ";
    }
    return null;
  }

  String? validateFirstName(String value) {
    if (value.isEmpty) {
      return "Please enter your first name";
    }
    return null;
  }

  String? validateLastName(String value) {
    if (value.isEmpty) {
      return "Please enter your last name";
    }
    return null;
  }

  String? validateTextField(String value) {
    if (value.isEmpty) {
      return "Field cannot be empty.";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Enter a valid password";
    } else if (value.length < 8) {
      return " Password must be at least 8 characters";
    } else if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one number";
    }
    return null;
  }

  String? validatePassword2(String value, String value2) {
    if (value.isEmpty) {
      return "Enter a valid password";
    } else if (value.length < 8) {
      return " Password must be at least 8 characters";
    } else if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one number";
    } else if (value != value2) {
      return "Passwords do not match";
    }
    return null;
  }

  String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return "Phone number can not be Empty.";
    }
    //  else if (value.length < 10) {
    //   return "Phone Number is not complete.";
    // }
    // else if (!value.isNumber) {
    //   return "Input only numbers";
    // }
    return null;
  }

  String? validatePinCode(String value) {
    if (value.length < 5) {
      return "Pin is not complete.";
    } else {
      return null;
    }
  }

  String? validatePinCode2(String value) {
    if (value.length < 3) {
      return "Pin is not complete.";
    } else {
      return null;
    }
  }
}
