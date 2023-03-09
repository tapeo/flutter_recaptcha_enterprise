package it.matteoricupero.flutter_recaptcha_enterprise

import android.app.Application
import android.util.Log
import androidx.annotation.NonNull
import com.google.android.recaptcha.Recaptcha
import com.google.android.recaptcha.RecaptchaAction
import com.google.android.recaptcha.RecaptchaClient
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.DelicateCoroutinesApi
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class FlutterRecaptchaEnterprisePlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var recaptchaClient: RecaptchaClient

    private lateinit var application: Application

    private val TAG: String = "RecaptchaPlugin"

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        application = flutterPluginBinding.applicationContext as Application

        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_recaptcha_enterprise")
        channel.setMethodCallHandler(this)
    }

    @OptIn(DelicateCoroutinesApi::class)
    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "setup") {
            GlobalScope.launch {
                Recaptcha.getClient(application, call.argument<String>("siteKey") as String)
                        .onSuccess { client ->
                            recaptchaClient = client
                            result.success("success")
                            Log.d(TAG, "client setup success")
                        }
                        .onFailure { exception ->
                            Log.d(TAG, exception.message!!)
                            result.error(exception.message!!, null, null)
                        }
            }
        } else if (call.method == "execute") {
            Log.d(TAG, "executing action")

            GlobalScope.launch {
                val recaptchaAction: RecaptchaAction = when (call.argument<String>("action") as String) {
                    "login" -> RecaptchaAction.LOGIN
                    "signup" -> RecaptchaAction.SIGNUP
                    else -> {
                        RecaptchaAction.custom(call.argument<String>("action") as String)
                    }
                }

                recaptchaClient.execute(recaptchaAction)
                        .onSuccess { token ->
                            result.success(token)
                        }
                        .onFailure { exception ->
                            Log.d(TAG, exception.message!!)
                            result.error(exception.message!!, null, null)
                        }
            }
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

}
