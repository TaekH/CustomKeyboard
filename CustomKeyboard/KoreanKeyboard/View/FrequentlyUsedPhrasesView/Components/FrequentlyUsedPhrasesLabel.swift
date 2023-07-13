//
//  FrequentlyUsedPhrasesLabel.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/14.
//

import UIKit

final class FrequentlyUsedPhrasesLabel: UIButton {
    var text: String
    init(_ text: String) {
        self.text = text
        super.init(frame: .zero)
        self.setTitle(text, for: .normal)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        if #available(iOS 15.0, *) {
            var buttonConfig = UIButton.Configuration.filled()
            var buttonTitleAttribute = AttributedString()
            buttonTitleAttribute.font = .systemFont(ofSize: 20)
            buttonConfig.attributedTitle = buttonTitleAttribute
            buttonConfig.baseForegroundColor = .white
            buttonConfig.baseBackgroundColor = .clear
            self.configuration = buttonConfig
        } else {
            self.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            self.backgroundColor = .clear
            self.setTitleColor(.white, for: .normal)
        }
    }
}
