//
//  ShortCutButtons.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/17.
//

import UIKit

final class ShortCutButtons: UIButton {
    
    init(_ title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        self.titleLabel?.textAlignment = .center
        self.backgroundColor = .systemGray
        self.setTitleColor(.white, for: .normal)
    }
}
