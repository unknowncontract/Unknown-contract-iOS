//
//  DesignSystem.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/30.
//

import Foundation
import UIKit

public enum DesignSystemAsset {

    public enum AntarcticBlue{
        public static let antarcticBlue100 = UIColor(named: "AntarcticBlue100")!
        public static let antarcticBlue200 = UIColor(named: "AntarcticBlue200")!
        public static let antarcticBlue300 = UIColor(named: "AntarcticBlue300")!
        public static let antarcticBlue400 = UIColor(named: "AntarcticBlue400")!
        public static let antarcticBlue500 = UIColor(named: "AntarcticBlue500")!
        public static let antarcticBlue600 = UIColor(named: "AntarcticBlue600")!
        public static let antarcticBlue700 = UIColor(named: "AntarcticBlue700")!
        public static let antarcticBlue800 = UIColor(named: "AntarcticBlue800")!
        public static let antarcticBlue900 = UIColor(named: "AntarcticBlue900")!
        public static let antarcticBlue1000 = UIColor(named: "AntarcticBlue1000")!
    }
    
    public enum Icon {
        public static let arrowRight = UIImage(named: "ArrowRight")!
        public static let arrowUp = UIImage(named: "ArrowUp")!
        public static let arrowDown = UIImage(named: "ArrowDown")!
        public static let arrowLeft = UIImage(named: "ArrowLeft")!
        public static let close = UIImage(named: "Close")!
        public static let whiteClose = UIImage(named: "WhiteClose")!
        public static let info = UIImage(named: "Info")!
        public static let shutter = UIImage(named: "Shutter")!
        public static let gov = UIImage(named: "Gov")!
        public static let court = UIImage(named: "Court")!
    }
    
    public enum Pretendard {
        public static let title1 = UIFont(name: "Pretendard-Bold", size: 32)!
        public static let title2 = UIFont(name: "Pretendard-Medium", size: 24)!
        public static let body1 = UIFont(name: "Pretendard-Medium", size: 16)!
        public static let body2 = UIFont(name: "Pretendard-Regular", size: 14)!
        public static let body3 = UIFont(name: "Pretendard-Regular", size: 12)!
    }
}
