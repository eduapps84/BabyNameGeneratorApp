//
//  FontHelper.swift
//  BabyNameGeneratorApp
//
//  Created by Eduardo Maia on 18/01/23.
//

import UIKit

struct FontHelper {
    
    enum RobotoType: String {
        case regular = "Roboto-Regular"
        case bold = "Roboto-Bold"
    }
    
    static func roboto(type: RobotoType, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
}
