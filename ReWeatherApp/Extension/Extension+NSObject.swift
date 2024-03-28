//
//  Extension+NSObject.swift
//  ReWeatherApp
//
//  Created by Alikhan Tursunbekov on 28/3/24.
//

import Foundation
import UIKit

extension NSObject {
    func DHeight(to: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.height * to / 932
    }
    func DWidth(to: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.width * to / 430
    }
}
