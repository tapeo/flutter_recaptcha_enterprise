# flutter_recaptcha_enterprise_example

Demonstrates how to use the flutter_recaptcha_enterprise plugin.

## Getting Started

0. follow https://cloud.google.com/recaptcha-enterprise/docs/instrument-ios-apps
1. Generate siteKey in GCP for Android and iOS
2. implementation 'com.google.android.recaptcha:recaptcha:18.0.1'
3. <uses-permission android:name="android.permission.INTERNET" />
4. remove headers from info.plist in Pods/RecaptchaEnterprise folder
5. add RecaptchaEnterprise to Pods - flutter_recaptcha_enterprise - Build Phases - Link Binary with libraries
6. Ensure that -ObjC is listed on your linker flags. Navigate to Target > Build Settings > All > Linking and verify that Other Linker Flags shows -ObjC.