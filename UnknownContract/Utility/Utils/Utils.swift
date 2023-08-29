//
//  Utils.swift
//  Unknown contract
//
//  Created by yongbeomkwak on 2023/08/28.
//

import Foundation
import UIKit
import AVFoundation

public var isCameraAuthorized: Bool {
  AVCaptureDevice.authorizationStatus(for: .video) == .authorized
}

public func APP_WIDTH() -> CGFloat {
    return UIScreen.main.bounds.size.width
}

public func APP_HEIGHT() -> CGFloat {
    return UIScreen.main.bounds.size.height
}


public func STATUS_BAR_HEGHIT() -> CGFloat {
    
if #available(iOS 15.0, *) {
            let top = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first?.safeAreaInsets.top ?? 0

            return max(20,top)

        } else {
            let top = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
            return max(20,top)
        }

    
}

public func SAFEAREA_BOTTOM_HEIGHT() -> CGFloat {
    if #available(iOS 15.0, *) {
                let bottom = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first?.safeAreaInsets.bottom ?? 0

                return max(20,bottom)

            } else {
                let bottom = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0
                return max(20,bottom)
            }
}

public func APP_VERSION() -> String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
}

public func APP_NAME() -> String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
}

// use: colorFromRGB(0xffffff)
public func colorFromRGB(_ rgbValue: UInt, alpha: CGFloat = 1.0) -> UIColor {
    return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                   green: CGFloat((rgbValue & 0xFF00) >> 8) / 255.0,
                   blue: CGFloat(rgbValue & 0xFF) / 255.0, alpha: alpha)
}

// use: colorFromRGB("ffffff")
public func colorFromRGB(_ hexString: String, alpha: CGFloat = 1.0) -> UIColor {
    let hexToInt = UInt32(Float64("0x" + hexString) ?? 0)
    return UIColor(red: CGFloat((hexToInt & 0xFF0000) >> 16) / 255.0,
                   green: CGFloat((hexToInt & 0xFF00) >> 8) / 255.0,
                   blue: CGFloat(hexToInt & 0xFF) / 255.0, alpha: alpha)
}

public func DEBUG_LOG(_ msg: Any, file: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
        let fileName = file.split(separator: "/").last ?? ""
        let funcName = function.split(separator: "(").first ?? ""
        print("[\(fileName)] \(funcName)(\(line)): \(msg)")
    #endif
}
