//
//  FrequentlyUsedPhrasesButton.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/14.
//

import UIKit

final class FrequentlyUsedPhrasesButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        if #available(iOS 15.0, *) {
            var buttonConfig = UIButton.Configuration.filled()
            var buttonTitleAttribute = AttributedString()
            buttonTitleAttribute.font = .systemFont(ofSize: Size.toolbarButtonLabelSize)
            buttonConfig.attributedTitle = buttonTitleAttribute
            buttonConfig.titleAlignment = .center
            buttonConfig.contentInsets = Size.keyEdgeInsetsForConfigure()
            buttonConfig.baseForegroundColor = .white
            buttonConfig.baseBackgroundColor = .systemGray
            self.setTitle("자주 쓰는 말", for: .normal)
            self.layer.cornerRadius = Size.keyRadius
            self.configuration = buttonConfig
        } else {
            self.contentEdgeInsets = Size.keyEdgeInsets()
            self.titleLabel?.font = UIFont.systemFont(ofSize: Size.toolbarButtonLabelSize)
            self.setTitle("자주 쓰는 말", for: .normal)
            self.titleLabel?.textAlignment = .center
            self.backgroundColor = .systemGray
            self.setTitleColor(.white, for: .normal)
            self.layer.cornerRadius = Size.keyRadius
        }
    }
}

