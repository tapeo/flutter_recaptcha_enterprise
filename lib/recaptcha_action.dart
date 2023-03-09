class RecaptchaAction {
  final String key;

  const RecaptchaAction(this.key);

  factory RecaptchaAction.login() {
    return const RecaptchaAction("login");
  }
  factory RecaptchaAction.signup() {
    return const RecaptchaAction("signup");
  }
  factory RecaptchaAction.custom(String action) {
    return RecaptchaAction(action);
  }
}
