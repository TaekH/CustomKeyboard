//
//  ShortCutsView.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/17.
//

import UIKit

final class ShortCutsView: UIView {
    
    init() {
        super.init(frame: .zero)
        configure()
        setUpShortCutsButtonLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .gray
    }
}

private extension ShortCutsView {
    func setUpShortCutsButtonLayout() {
        var firstButton: ShortCutButtons?
        for idx in 0..<Value.shortCutListCount {
            let text = shortCutList[idx]
            let button = ShortCutButtons(text)
            addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            if let firstButton = firstButton {
                button.leadingAnchor.constraint(equalTo: firstButton.trailingAnchor).isActive = true
            } else {
                button.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            }
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: self.topAnchor),
                button.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
            firstButton = button
        }
    }
}
