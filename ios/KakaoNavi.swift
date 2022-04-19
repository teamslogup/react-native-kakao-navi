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
    
    @objc(navigate:options:)
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
        let naviOption = NaviOption(
            coordType: CoordType.WGS84
        )
        if let startX = options?["startX"], startY = options?["startY"] {
            naviOption.startX = startX
            naviOption.startY= startY
        }
        
        guard let navigateUrl = NaviApi.shared.navigateUrl(destination: destination, option: naviOption) else {
            return
        }

        DispatchQueue.main.async {
            if UIApplication.shared.canOpenURL(navigateUrl) {
                UIApplication.shared.open(navigateUrl, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.open(NaviApi.webNaviInstallUrl, options: [:], completionHandler: nil)
            }
        }
    }
    
    @objc static func requiresMainQueueSetup() -> Bool {
        return false
    }
}
