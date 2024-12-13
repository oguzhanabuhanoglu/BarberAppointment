//
//  SubtitleLabel.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 6.12.2024.
//

import Foundation
import UIKit

class SubtitleLabel: UILabel {
    
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        self.textAlignment = .left
        self.textColor = .white
        self.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
