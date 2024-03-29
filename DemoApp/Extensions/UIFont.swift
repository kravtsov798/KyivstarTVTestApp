//
//  UIFont.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 27.03.2024.
//

import SwiftUI
import UIKit

extension UIFont {
    public class func robotoFont(ofSize fontSize: CGFloat) -> UIFont? {
        UIFont(name: "Roboto-Regular", size: fontSize)
    }
}
