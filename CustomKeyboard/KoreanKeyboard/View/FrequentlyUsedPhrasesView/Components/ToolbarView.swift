//
//  ToolBarView.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/14.
//

import UIKit

final class ToolbarView: UIView {
    
    let frequentlyUsedPhrasesButton = FrequentlyUsedPhrasesButton()
    
    init() {
        super.init(frame: .zero)
        configure()
        setUpButtonLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .darkGray
    }
}

private extension ToolbarView {
    func setUpButtonLayout() {
        self.addSubview(frequentlyUsedPhrasesButton)
        frequentlyUsedPhrasesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            frequentlyUsedPhrasesButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            frequentlyUsedPhrasesButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            frequentlyUsedPhrasesButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}
