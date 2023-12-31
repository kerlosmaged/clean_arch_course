bool isEmailValid({required String email}) {
  return RegExp(
          r" /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/")
      .hasMatch(email);
}
