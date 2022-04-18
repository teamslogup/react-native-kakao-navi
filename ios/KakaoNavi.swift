import KakaoSDKCommon
import KakaoSDKNavi
import Foundation

@objc(KakaoNavi)
class KakaoNavi: NSObject {
    var isKakaoSdkInitialized = false
    
    @objc(initSdk:)
    func initSdk(kakaoSdkKey: String) -> Void {
        KakaoSDK.initSDK(appKey: kakaoSdkKey)
        isKakaoSdkInitialized = true
    }
    
    @objc(navigate::)
    func navigate(location: Dictionary<String, String>, options: Dictionary<String, String>?) -> Void {
        if(!isKakaoSdkInitialized) {
            return
        }
        
        let name = location["name"] ?? ""
        let x = location["x"] ?? ""
        let y = location["y"] ?? ""
        
        if (name.isEmpty || x.isEmpty || y.isEmpty) {
            return
        }
        
        let destination = NaviLocation(name: name, x: x, y: y)
        guard let navigateUrl = NaviApi.shared.navigateUrl(destination: destination) else {
            return
        }

        if UIApplication.shared.canOpenURL(navigateUrl) {
            let naviOption: [UIApplication.OpenExternalURLOptionsKey : Any] = [
                UIApplication.OpenExternalURLOptionsKey.init(rawValue: "coordType"): CoordType.WGS84,
                UIApplication.OpenExternalURLOptionsKey.init(rawValue: "startX"): options?["startX"] as Any,
                UIApplication.OpenExternalURLOptionsKey.init(rawValue: "startY"): options?["startY"] as Any
            ]
            UIApplication.shared.open(navigateUrl, options: naviOption, completionHandler: nil)
        } else {
            UIApplication.shared.open(NaviApi.webNaviInstallUrl, options: [:], completionHandler: nil)
        }
    }
    
    @objc static func requiresMainQueueSetup() -> Bool {
        return false
    }
}
