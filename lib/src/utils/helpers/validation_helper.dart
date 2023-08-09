import 'package:flutter/material.dart';

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
      return "Pin can not be empty";
    } else if (value.length < 6) {
      return "Pin must be 6 characters";
    } else if (!value.contains(RegExp(r'[0-9]'))) {
      return "Pin can only be numbers";
    }
    return null;
  }

  String? validatePassword2(String value, String value2) {
    if (value.isEmpty) {
      return "Pin can not be empty";
    } else if (value.length < 6) {
      return "Pin must be 6 characters";
    } else if (!value.contains(RegExp(r'[0-9]'))) {
      return "Pin must can only be numbers";
    } else if (value != value2) {
      return "Passwords do not match";
    }
    return null;
  }

  String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return "Number can not be Empty.";
    }
    //  else if (value.length < 10) {
    //   return "Phone Number is not complete.";
    // }
    // else if (!value.isNumber) {
    //   return "Input only numbers";
    // }
    return null;
  }

  String? validateAccountNumber(String value) {
    if (value.isEmpty) {
      return "Account number can not be Empty.";
    } else if (value.length < 10) {
      return "Account number is not complete.";
    }
    return null;
  }

  String? validateAmount(String value) {
    if (value.isEmpty) {
      return "Amount can not be Empty.";
    } else if (int.parse(value) < 10) {
      return "Amount can't be less than 10 Naira.";
    }
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
    } else if (value.isEmpty) {
      return "Pin can not be empty";
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

  String? validateOldPasscode(String value) {
    if (value.length < 3) {
      return "Passcode is not complete.";
    } else if (value.isEmpty) {
      return "Passcode can not be empty";
      // } else if (value != value2) {
      //   return "Passcode is not correct.";
    } else {
      return null;
    }
  }

  String? validateNewPasscode(String value) {
    if (value.length < 3) {
      return "Passcode is not complete.";
    } else if (value.isEmpty) {
      return "Passcode can not be empty";
    } else {
      return null;
    }
  }

  String? validateConfirmNewPasscode(String value) {
    if (value.length < 3) {
      return "Passcode is not complete.";
    } else if (value.isEmpty) {
      return "Passcode can not be empty";
      // } else if (value != value2) {
      //   return "Passcode do not match.";
    } else {
      return null;
    }
  }
}
