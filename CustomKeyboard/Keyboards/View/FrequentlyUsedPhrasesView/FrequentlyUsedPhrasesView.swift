//
//  FrequentlyUsedPhrasesView.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/14.
//

import UIKit

protocol FrequentlyUsedPhrasesViewDelegate: AnyObject {
    func setFrequentlyUsedPhrases(_ text: String)
}

final class FrequentlyUsedPhrasesView: UIView {
    
    weak var delegate: FrequentlyUsedPhrasesViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "자주 쓰는 말"
        label.font = UIFont.systemFont(ofSize: Size.frequentlyUsedPhrasesLabelSize)
        label.textColor = .white
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        configure()
        setUpTitleLabel()
        setUpFrequentlyUsedPhrasesLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .systemGray
    }
    
    @objc func frequentlyUsedPhrasesPressed (_ sender: FrequentlyUsedPhrasesLabel) {
        delegate?.setFrequentlyUsedPhrases(sender.text)
    }
}

private extension FrequentlyUsedPhrasesView {
    
    func setUpTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Size.frequentlyUsedPhrasesRowSpacing),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Size.frequentlyUsedPhrasesLeadingSpacing),
        ])
    }
    
    func setUpFrequentlyUsedPhrasesLabel() {
        var firstButton: FrequentlyUsedPhrasesLabel?
        for idx in 0..<Value.frequentlyUsedPhrasesListCount {
            let text = frequentlyUsedPhrasesList[idx]
            let button = FrequentlyUsedPhrasesLabel(text)
            button.addTarget(self, action: #selector(frequentlyUsedPhrasesPressed), for: .touchUpInside)
            addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            if let firstButton = firstButton {
                button.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: Size.frequentlyUsedPhrasesRowSpacing).isActive = true
            } else {
                button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Size.frequentlyUsedPhrasesRowSpacing).isActive = true
            }
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Size.frequentlyUsedPhrasesLeadingSpacing)
            ])
            firstButton = button
        }
    }
}
