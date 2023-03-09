# flutter_recaptcha_enterprise

Integrate Google Recaptcha Enterprise on Flutter

## Usage

Setup the object:

`final flutterRecaptchaEnterprise = FlutterRecaptchaEnterprise();`

Define the site keys for Android and iOS using:

`flutterRecaptchaEnterprise.setupAndroid(siteKeyAndroid);`

and

`flutterRecaptchaEnterprise.setupIOS(siteKeyIOS);`

then retrieve the Recaptcha token passing a [customAction] string with:

`String token = await flutterRecaptchaEnterprise.execute(RecaptchaAction.custom(customAction));`
