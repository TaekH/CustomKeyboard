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
    
    init() {
        super.init(frame: .zero)
        configure()
        setUpLabel()
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
    func setUpLabel() {
        for idx in 0..<Value.frequentlyUsedPhrasesListCount {
            let text = frequentlyUsedPhrasesList[idx]
            let button = FrequentlyUsedPhrasesLabel(text)
            button.addTarget(self, action: #selector(frequentlyUsedPhrasesPressed), for: .touchUpInside)
            addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            if idx == 0 {
                button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            } else {
                let firstButton = subviews[idx - 1]
                button.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 5).isActive = true
            }
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                button.heightAnchor.constraint(equalToConstant: 30),
            ])
            
        }
    }
}
