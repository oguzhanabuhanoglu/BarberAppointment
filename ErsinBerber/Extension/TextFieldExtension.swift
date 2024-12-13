//
//  Extensions.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 3.12.2024.
//

import Foundation
import UIKit

extension UITextField {
    func addLeftPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
