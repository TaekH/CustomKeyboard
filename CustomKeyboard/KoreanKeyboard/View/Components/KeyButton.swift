//
//  KeyButton.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/12.
//

import UIKit

final class KeyButtonView: UIView {
    
    var keyButton: UIButton = {
        let keyButton = UIButton()
        if #available(iOS 15.0, *) {
            var buttonConfig = UIButton.Configuration.filled()
            var buttonTitleAttribute = AttributedString()
            buttonTitleAttribute.font = .systemFont(ofSize: 17)
            buttonConfig.attributedTitle = buttonTitleAttribute
            buttonConfig.titleAlignment = .center
            buttonConfig.contentInsets = Size.keyEdgeInsetsForConfigure()
            buttonConfig.baseBackgroundColor = .systemGray
            keyButton.layer.cornerRadius = Size.keyRadius
            keyButton.configuration = buttonConfig
        } else {
            keyButton.contentEdgeInsets = Size.keyEdgeInsets()
            keyButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            keyButton.titleLabel?.textAlignment = .center
            keyButton.backgroundColor = .systemGray
            keyButton.setTitleColor(.white, for: .normal)
            keyButton.layer.cornerRadius = Size.keyRadius
        }
        return keyButton
    }()
    var keyValue: KeyModel
    var tmp = "hi"
    
    
    init(key: KeyModel) {
        keyValue = key
        super.init(frame: .zero)
        
        keyButton.setTitle(key.keyword, for: .normal)
        setUpKeyButtonLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension KeyButtonView {
    func setUpKeyButtonLayout() {
        addSubview(keyButton)
        keyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            keyButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            keyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            keyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3),
            keyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
