//
//  KeyButton.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/12.
//

import UIKit

final class KeyButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setUpKeyButtonLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(_ title: String) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
    }
    
    private func configure() {
        if #available(iOS 15.0, *) {
            var buttonConfig = UIButton.Configuration.filled()
            var buttonTitleAttribute = AttributedString()
            buttonTitleAttribute.font = .systemFont(ofSize: 20)
            buttonConfig.attributedTitle = buttonTitleAttribute
            buttonConfig.titleAlignment = .center
            buttonConfig.contentInsets = Size.keyEdgeInsetsForConfigure()
            buttonConfig.baseBackgroundColor = .systemGray
            configuration = buttonConfig
        } else {
            contentEdgeInsets = Size.keyEdgeInsets()
            titleLabel?.font = UIFont.systemFont(ofSize: 20)
            titleLabel?.textAlignment = .center
            backgroundColor = .systemGray
            setTitleColor(.white, for: .normal)
            layer.cornerRadius = Size.keyRadius
        }
    }
}

private extension KeyButton {
    func setUpKeyButtonLayout() {
        widthAnchor.constraint(equalToConstant: Size.keyWidth).isActive = true
        heightAnchor.constraint(equalToConstant: Size.keyHeight).isActive = true
    }
}
