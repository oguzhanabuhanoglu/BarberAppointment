//
//  VerificationTextField.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 10.12.2024.
//

import Foundation
import UIKit

class VerificationTextField: UITextField {
    
    init() {
        super.init(frame: .zero)
        self.textColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "mainYellow")?.cgColor
        self.backgroundColor = .black
        self.textAlignment = .center
        self.layer.cornerRadius = 10
        self.keyboardType = .numberPad
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
