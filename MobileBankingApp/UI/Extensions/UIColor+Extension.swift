//
//  UIColor+Extension.swift
//  MobileBankingApp
//
//  Created by Miran Mendelski on 09.04.2024..
//

import UIKit

extension UIColor {
    
    static let darkInput = rgb(32, 31, 31)
    static let darkButton = rgb(34, 34, 34)
    static let darkStroke = rgb(75, 75, 75)
    static let greyStroke = rgb(118, 118, 118)
    static let darkGray2 = rgb(24,24,24)
    
    static let grayText2 = rgb(196,196,196)
    
    static let yellowRBA = rgb(255,237, 0, 0.2)
    static let yellowRBABorder = rgb(255,240, 53)
    
    static let error = rgb(241, 87,87)
    
}


fileprivate extension UIColor {
    
    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
}
