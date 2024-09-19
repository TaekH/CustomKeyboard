//
//  ToolBarView.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/14.
//

import UIKit

protocol ToolbarViewDelegate: AnyObject {
    func setFrequentlyUsedPhrasesView(_ isSelected: Bool)
}

final class ToolbarView: UIView {
    
    let frequentlyUsedPhrasesButton = FrequentlyUsedPhrasesButton()
    weak var delegate: ToolbarViewDelegate?
    
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
    
    
    @objc func frequentlyUsedPhrasesButtonPressed (_ sender: FrequentlyUsedPhrasesButton) {
        sender.isSelected = !sender.isSelected
        delegate?.setFrequentlyUsedPhrasesView(sender.isSelected)
    }
}

private extension ToolbarView {
    func setUpButtonLayout() {
        self.addSubview(frequentlyUsedPhrasesButton)
        frequentlyUsedPhrasesButton.addTarget(self, action: #selector(frequentlyUsedPhrasesButtonPressed), for: .touchUpInside)
        frequentlyUsedPhrasesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            frequentlyUsedPhrasesButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Size.toolbarButtonSpacing),
            frequentlyUsedPhrasesButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Size.toolbarButtonSpacing),
            frequentlyUsedPhrasesButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Size.toolbarButtonSpacing)
        ])
    }
}
