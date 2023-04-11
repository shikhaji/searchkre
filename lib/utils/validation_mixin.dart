mixin ValidationMixin {
  String? fatherNameValidator(String? fatherName) {
    if (fatherName!.isNotEmpty) {
      return null;
    } else {
      return 'Please Enter Father Name';
    }
  }

  String? businessNameValidator(String? businessName) {
    if (businessName!.isNotEmpty) {
      return null;
    } else {
      return 'Please Enter Business Name';
    }
  }

  String? motherNameValidator(String? motherName) {
    if (motherName!.isNotEmpty) {
      return null;
    } else {
      return 'Please Enter Mother Name';
    }
  }

  String? nameValidator(String? name) {
    if (name!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Name";
    }
  }

  String? msgValidator(String? msg) {
    if (msg!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Message";
    }
  }

  String? lastNameValidator(String? lastName) {
    if (lastName!.isNotEmpty) {
      return null;
    } else {
      return 'Please Enter Last Name';
    }
  }

  String? amountValidator(String? amount) {
    if (amount!.isNotEmpty) {
      return null;
    } else {
      return 'Please Enter Amount';
    }
  }

  String? dateOfBirth(String? dob) {
    if (dob!.isNotEmpty) {
      return null;
    } else {
      return 'Please Enter DOB';
    }
  }

  String? titleValidation(String? title) {
    if (title!.isNotEmpty) {
      return null;
    } else {
      return 'Please Enter Title';
    }
  }

  String? emailValidator(String? email, {bool isLogin = false}) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());

    if (email!.isNotEmpty) {
      if (isLogin == false) {
        if (regex.hasMatch(email)) {
          return null;
        } else {
          return "Please Enter Valid Email";
        }
      }
      return null;
    } else {
      return "Please Enter Your Email";
    }
  }

  String? mobileNumberValidator(String? mobileNumber) {
    if (mobileNumber!.isNotEmpty) {
      if (mobileNumber.length != 10) {
        return "Please enter valid mobile number";
      }
      return null;
    } else {
      return "Please Enter Mobile Number";
    }
  }

  String? passwordValidator(String? password, {bool isLogin = false}) {
    if (password!.isNotEmpty) {
      if (isLogin == false) {
        if (password.length <= 6) {
          return "Password Is Too Short";
        }
      }
      return null;
    } else {
      return "Please Enter Your Password";
    }
  }

  String? confirmPasswordValidator(String value, String? password) {
    if (password!.isNotEmpty) {
      if (value != password) {
        return 'Password Does Not Match';
      }
      return null;
    } else {
      return "Please Enter Your Password";
    }
  }

  String? oldPasswordValidator(String? oldPassword) {
    if (oldPassword!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Old Password";
    }
  }

  // ======= create job ========= //

  String? patientNameValidation(String? patientName) {
    if (patientName!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Patient Name";
    }
  }

  String? pickUpLocationValidation(String? pickupLocation) {
    if (pickupLocation!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Pickup Location";
    }
  }

  String? dropOffUpLocationValidation(String? dropOffLocation) {
    if (dropOffLocation!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Drop-off Location";
    }
  }

  String? pickupDateValidation(String? pickupDate) {
    if (pickupDate!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Date";
    }
  }

  String? startTimeValidation(String? startTime) {
    if (startTime!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Start Time";
    }
  }

  String? endTimeValidation(String? endTime) {
    if (endTime!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter End Time";
    }
  }

  String? addressValidation(String? address) {
    if (address!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Address";
    }
  }

  String? qualificationValidation(String? qualification) {
    if (qualification!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Qualification";
    }
  }

  String? businessTypeValidation(String? businessType) {
    if (businessType!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Business Type";
    }
  }

  String? experienceValidation(String? experience) {
    if (experience!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Experience";
    }
  }

  String? descriptionValidation(String? description) {
    if (description!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Description";
    }
  }

  String? cityValidation(String? city) {
    if (city!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter City";
    }
  }

  String? stateValidation(String? state) {
    if (state!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter State";
    }
  }

  String? zipCodeValidation(String? state) {
    if (state!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Zip Code";
    }
  }

  String? countryValidation(String? state) {
    if (state!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Country";
    }
  }

  String? totalValue(String? totalValue) {
    if (totalValue!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Total Item Cost";
    }
  }

  String? estimatedCost(String? estimatedCost) {
    if (estimatedCost!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Estimated Cost";
    }
  }

  String? serviceFees(String? serviceFees) {
    if (serviceFees!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Service Fees";
    }
  }

  String? itemNameValidation(String? itemName) {
    if (itemName!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Item Name";
    }
  }

  String? quantityValidation(String? quantity) {
    if (quantity!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Quantity";
    }
  }

  String? cardTypeValidation(String? cardType) {
    if (cardType!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Card Type";
    }
  }

  String? cardNumberValidation(String? cardNumber) {
    if (cardNumber!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Card Number";
    }
  }

  String? cardExpMonthValidation(String? cardExpMonth) {
    if (cardExpMonth!.isNotEmpty) {
      if (int.parse(cardExpMonth) >= 13) {
        return "Please Enter Valid Month";
      }
      return null;
    } else {
      return "Please Enter Card Exp. Month";
    }
  }

  int currentYear = DateTime.now().year;

  String? cardExpYearValidation(String? cardExpYear) {
    if (cardExpYear!.isNotEmpty) {
      if (int.parse(cardExpYear) < currentYear) {
        return "Please Enter Valid Year";
      }
      return null;
    } else {
      return "Please Enter Card Exp. Year";
    }
  }

  String? cardSecurityCodeValidation(String? cardSecurityCode) {
    if (cardSecurityCode!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Card Security Code";
    }
  }

  String? postalCodeValidation(String? code) {
    if (code!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Postal Code";
    }
  }
}
