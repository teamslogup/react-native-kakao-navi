import { NativeModules, Platform } from 'react-native';

interface Location {
  name: string;
  x: string;
  y: string;
}

interface NaviOption {
  startX: string;
  startY: string;
}

const LINKING_ERROR =
  `The package 'react-native-kakao-navi' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

const KakaoNavi = NativeModules.KakaoNavi
  ? NativeModules.KakaoNavi
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

const initSdk = (kakaoSdkKey: string) => {
  KakaoNavi.initSdk(kakaoSdkKey);
};

const navigate = (location: Location, options?: NaviOption) => {
  KakaoNavi.navigate(location, options);
};

export { initSdk, navigate };
