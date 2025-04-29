package com.hdk24.flutter

import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.provider.Settings
import android.text.TextUtils
import androidx.browser.customtabs.CustomTabColorSchemeParams
import androidx.browser.customtabs.CustomTabsIntent
import androidx.core.content.ContextCompat
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.hdk24.flutter"
        ).setMethodCallHandler { call, result ->
            if (call.method == "open_settings") {
                openAppSettings(call)
            } else if (call.method == "open_url") {
                openUrl(call)
            } else if (call.method == "open_file") {
                openFile(call, result)
            } else if (call.method == "share_text") {
                shareText(call)
            }
        }
    }

    private fun openAppSettings(call: MethodCall) {
        val asAnotherTask = call.argument("asAnotherTask") ?: false
        val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
        if (asAnotherTask) intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        val uri = Uri.fromParts("package", this.activity.packageName, null)
        intent.data = uri
        this.activity.startActivity(intent)
    }

    private fun openUrl(call: MethodCall) {
        val urlLink: String? = call.argument("urlLink")
        val inAppBrowser: Boolean = call.argument("inAppBrowser") ?: false
        if (inAppBrowser) {
            try {
                val customTabsBuilder = CustomTabsIntent.Builder()
                customTabsBuilder.setShowTitle(true)
                val color = ContextCompat.getColor(context, R.color.primary_color)
                customTabsBuilder.setDefaultColorSchemeParams(
                    CustomTabColorSchemeParams.Builder().setToolbarColor(color).build()
                )
                val customTabsIntent: CustomTabsIntent = customTabsBuilder.build()
                customTabsIntent.intent.setPackage("com.android.chrome")
                customTabsIntent.launchUrl(this, Uri.parse(urlLink))
            } catch (e: PackageManager.NameNotFoundException) {
                openExternalBrowser(urlLink)
            }
        } else {
            openExternalBrowser(urlLink)
        }
    }

    private fun openExternalBrowser(urlLink: String?) {
        if (urlLink.isNullOrEmpty()) return
        val openURL = Intent(Intent.ACTION_VIEW)
        openURL.data = Uri.parse(urlLink)
        startActivity(openURL)
    }

    private fun openFile(call: MethodCall, result: Result) {
        val path: String? = call.argument("file_path")
        val type: String? = call.argument("type")
        if (path.isNullOrEmpty() || type.isNullOrEmpty()) return

        val uri: Uri = FileProvider.getUriForFile(
            this, "${applicationContext.packageName}.provider", File(path)
        )
        val shareIntent = Intent(Intent.ACTION_VIEW).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK
            flags = Intent.FLAG_GRANT_READ_URI_PERMISSION
            addCategory(Intent.CATEGORY_DEFAULT)
            setDataAndType(uri, type)
        }
        try {
            startActivity(Intent.createChooser(shareIntent, "Open File"))
            result.success("done")
        } catch (e: Exception) {
            result.error("PlatformException",e.toString(),null)
        }
    }

    private fun shareText(call: MethodCall) {
        try {
            val title: String? = call.argument("title")
            val text: String? = call.argument("text")
            val chooserTitle: String? = call.argument("chooserTitle")
            if (title.isNullOrEmpty()) return

            val intent = Intent().apply {
                flags = Intent.FLAG_ACTIVITY_CLEAR_TOP
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
                action = Intent.ACTION_SEND
                type = "text/plain"
                putExtra(Intent.EXTRA_SUBJECT, title)
                putExtra(Intent.EXTRA_TEXT, text)
            }

            val chooserIntent = Intent.createChooser(intent, chooserTitle).apply {
                flags = Intent.FLAG_ACTIVITY_CLEAR_TOP
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
            }
            startActivity(chooserIntent)
        } catch (_: Exception) {
        }
    }

}
