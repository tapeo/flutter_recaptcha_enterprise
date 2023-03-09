import Flutter
import UIKit
import Foundation
import RecaptchaEnterprise

public class FlutterRecaptchaEnterprisePlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_recaptcha_enterprise", binaryMessenger: registrar.messenger())
        let instance = FlutterRecaptchaEnterprisePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    var recaptchaClient: RecaptchaClient?
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as? Dictionary<String, Any>
        
        if (call.method == "setup") {
            let siteKey = args!["siteKey"] as? String
            
            Recaptcha.getClient(siteKey: siteKey!, completionHandler: { recaptchaClient, _ in
                if let recaptchaClient = recaptchaClient {
                    self.recaptchaClient = recaptchaClient
                }
                
                result("success")
            })
        } else if (call.method == "execute") {
            let action = args!["action"] as? String
            
            var recaptchaAction: RecaptchaAction
            
            switch action {
            case "login":
                recaptchaAction = RecaptchaAction(action: .login)
            case "signup":
                recaptchaAction = RecaptchaAction(action: .signup)
            default:
                recaptchaAction = RecaptchaAction(customAction: action!)
            }
            
            guard let recaptchaClient = recaptchaClient else {
                
                DispatchQueue.main.async {
                    result(FlutterError(code: "RecaptchaClient creation failed", message: nil, details: nil))
                }
                return
            }
            
            recaptchaClient.execute(recaptchaAction, completionHandler: { token , error in
                if let token = token {
                    result(token.recaptchaToken)
                } else {
                    result(FlutterError(code: "RecaptchaClient creation error: \(String(describing: error?.errorMessage)).", message: nil, details: nil))
                }
            })
            
        } else {
            result(FlutterError(code: "not implemented", message: nil, details: nil))
        }
    }
}
