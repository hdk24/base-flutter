import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(name: "id.flecto.wmp", binaryMessenger: controller.binaryMessenger)
        methodChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if (call.method == "open_settings") {
                self?.openAppSettings()
            } else if(call.method == "open_url"){
                self?.openUrl(call:call, controller:controller)
            } else if(call.method == "open_file"){
                self?.openFile(call:call, uiController: controller)
            } else if(call.method == "share_text"){
                self?.shareText(call:call, uiController:controller)
            } else {
                result(FlutterMethodNotImplemented)
            }
        })
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

    private func openUrl(call: FlutterMethodCall, controller:FlutterViewController) {
        let args = call.arguments as? [String: Any?]
        let urlLink = args!["urlLink"] as? String
        let inAppBrowser = args!["inAppBrowser"] as? Bool
        if (urlLink ?? "").isEmpty {
            return
        }
        if let inAppBrowser = inAppBrowser, inAppBrowser {
            if let url = URL(string: urlLink!) {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                let vc = SFSafariViewController(url: url, configuration: config)
                controller.present(vc, animated: true)
            }
        } else if let url = URL(string: urlLink!) {
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url)
            }
        }
    }

    private func openFile(call: FlutterMethodCall, uiController: FlutterViewController) {
        let args = call.arguments as? [String: Any?]
        let filePath = args!["file_path"] as? String

        let fileURL = URL(fileURLWithPath: filePath!)
        var filesToShare = [Any]()
        filesToShare.append(fileURL)

        let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
        uiController.present(activityViewController, animated: true, completion: nil)
    }

    private func shareText(call: FlutterMethodCall, uiController: FlutterViewController) {
        let args = call.arguments as? [String: Any?]
        let title = args!["title"] as? String
        let text = args!["text"] as? String

        if (text == nil || text!.isEmpty) {
            return
        }

        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        // so that iPads won't crash
        activityViewController.popoverPresentationController?.sourceView = uiController.view
        if (title != nil && title != "") {
            activityViewController.setValue(title, forKeyPath: "subject");
        }
        // Present the UIActivityViewController
        uiController.present(activityViewController, animated: true, completion: nil)
   }
}
