//
//  ShortCutsView.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/17.
//

import UIKit

protocol ShortCutsViewDelegate: AnyObject {
    func setShortCutTitle(with title: String)
}

final class ShortCutsView: UIView {
    weak var delegate: ShortCutsViewDelegate?
    
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
    
    @objc private func shortCutButtonPressed(_ sender: UIButton) {
         delegate?.setShortCutTitle(with: sender.currentTitle ?? "")
     }
}

private extension ShortCutsView {
    func setUpShortCutsButtonLayout() {
        var firstButton: ShortCutButtons?
        for idx in 0..<Value.shortCutListCount {
            let text = shortCutList[idx]
            let button = ShortCutButtons(text)
            button.addTarget(self, action: #selector(shortCutButtonPressed), for: .touchUpInside)
            addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            if let firstButton = firstButton {
                button.leadingAnchor.constraint(equalTo: firstButton.trailingAnchor).isActive = true
            } else {
                button.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            }
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: self.topAnchor),
                button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                button.widthAnchor.constraint(equalToConstant: Size.keyWidth)
            ])
            firstButton = button
        }
    }
}
