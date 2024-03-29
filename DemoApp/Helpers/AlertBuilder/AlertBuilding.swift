//
//  AlertBuilding.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 28.03.2024.
//

import UIKit

protocol AlertBuilding {
    @discardableResult
    func addTitle(_ title: String) -> Self
    
    @discardableResult
    func addMessage(_ message: String) -> Self
    
    @discardableResult
    func setStyle(_ style: UIAlertController.Style) -> Self
    
    @discardableResult
    func addAction(with actionTitle: String,
                   actionStyle: UIAlertAction.Style,
                   handler: @escaping ((UIAlertAction) -> Void)) -> Self
    
    @discardableResult
    func reset() -> Self
    
    func build() -> UIAlertController
}
