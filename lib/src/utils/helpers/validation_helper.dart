class ValidationHelper {
  String? validateUserName(String value) {
    if (value.length < 4) {
      return "Username must be more than 4 characters ";
    }
    return null;
  }

  String? validateFirstName(String value) {
    if (value.isEmpty) {
      return "Please enter your full name";
    }
    return null;
  }

  // String? validateLastName(String value) {
  //   if (value.isEmpty) {
  //     return "Please enter your last name";
  //   }
  //   return null;
  // }

  String? validateTextField(String value) {
    if (value.isEmpty) {
      return "Field cannot be empty.";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Enter a valid password";
    } else if (value.length < 6) {
      return " Pin cannot be more than 6 characters";
    } else if (!value.contains(RegExp(r'[0-9]'))) {
      return "Pin can only be numbers";
    }
    return null;
  }

  String? validatePassword2(String value, String value2) {
    if (value.isEmpty) {
      return "Enter a valid password";
    } else if (value.length < 6) {
      return " Pin cannot be more than 6 characters";
    } else if (!value.contains(RegExp(r'[0-9]'))) {
      return "Pin must can only be numbers";
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

  String? validateAmount(String value) {
    if (value.isEmpty) {
      return "Amount can not be Empty.";
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

  String? validatePasscode(String value) {
    if (value.length < 3) {
      return "Passcode is not complete.";
    } else if (value.isEmpty) {
      return "Passcode can not be empty";
    } else {
      return null;
    }
  }
}
