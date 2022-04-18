package com.reactnativekakaonavi

import android.content.Intent
import android.net.Uri
import android.util.Log
import com.facebook.react.bridge.*
import com.kakao.sdk.common.KakaoSdk
import com.kakao.sdk.navi.Constants
import com.kakao.sdk.navi.NaviClient
import com.kakao.sdk.navi.model.CoordType
import com.kakao.sdk.navi.model.Location
import com.kakao.sdk.navi.model.NaviOption

class KakaoNaviModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  var isInitialized = false

  override fun getName(): String {
    return "KakaoNavi"
  }

  @ReactMethod
  fun init(kakaoSdkKey: String, promise: Promise) {
    try {
      KakaoSdk.init(reactApplicationContext, kakaoSdkKey)
      isInitialized = true
      promise.resolve(true)
    } catch (e: Exception) {
      Log.e(TAG, e.localizedMessage ?: "Error")
      promise.reject(e)
    }
  }

  @ReactMethod
  fun navigate(location: ReadableMap, options: ReadableMap?, promise: Promise) {
    try {
      if (!isInitialized) throw Exception("Kakao Sdk is not initialized!")

      val name = location.getString("name") ?: ""
      val x = location.getString("x") ?: ""
      val y = location.getString("y") ?: ""

      if (arrayOf(name, x, y).any { it.isBlank() }) {
        throw Exception("Location is empty!")
      }

      // 카카오내비 앱으로 길 안내
      if (NaviClient.instance.isKakaoNaviInstalled(reactApplicationContext)) {
        val naviOption = NaviOption(
          coordType = CoordType.WGS84,
          startX = options?.getString("startX"),
          startY = options?.getString("startY")
        )

        reactApplicationContext.startActivity(
          NaviClient.instance.navigateIntent(
            Location(name, x, y),
            naviOption
          )
        )
        promise.resolve(true)
      } else {
        // 카카오내비 설치 페이지로 이동
        reactApplicationContext.startActivity(
          Intent(
            Intent.ACTION_VIEW,
            Uri.parse(Constants.WEB_NAVI_INSTALL)
          ).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
        )
        promise.resolve(false)
      }
    } catch (e: Exception) {
      Log.e(TAG, e.localizedMessage ?: "Error")
      promise.reject(e)
    }
  }

  companion object {
    private val TAG = this::class.simpleName
  }
}
