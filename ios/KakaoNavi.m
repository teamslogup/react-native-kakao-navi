#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(KakaoNavi, NSObject)

RCT_EXTERN_METHOD(initSdk:(NSString *)kakaoSdkKey)
RCT_EXTERN_METHOD(navigate:(NSDictionary *)location (nullable NSDictionary *)options)

@end
