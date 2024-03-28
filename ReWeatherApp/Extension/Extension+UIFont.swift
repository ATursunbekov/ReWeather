//
//  Extension+UIFont.swift
//  ReWeatherApp
//
//  Created by Alikhan Tursunbekov on 27/3/24.
//

import UIKit

enum CustomFontWeight: String {
    case regular
    case medium
    
    func fontName() -> String {
        switch self {
        case .regular:
            return "Inter-Regular"
        case .medium:
            return "Inter-Medium"
        }
    }
}

extension UIFont {
    static func inter(size: Int, weight fontWight: CustomFontWeight) -> UIFont {
        return UIFont(name: fontWight.fontName(), size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
}
