//
//  NSMutableAttributedString+Extension.swift
//  MobileBankingApp
//
//  Created by Miran Mendelski on 09.04.2024..
//

import UIKit

extension NSMutableAttributedString {
    
    func style(_ font: UIFont, color: UIColor = .black, alignment: NSTextAlignment = .left, range: NSRange? = nil) {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.paragraphStyle: paragraphStyle]
        
        self.addAttributes(attributes, range: range ?? NSRange(location: 0, length: self.length))
        
    }
}
