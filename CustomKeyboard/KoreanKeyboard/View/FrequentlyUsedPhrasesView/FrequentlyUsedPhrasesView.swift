//
//  FrequentlyUsedPhrasesView.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/14.
//

import UIKit

final class FrequentlyUsedPhrasesView: UIView {
    
    var frequentlyUsedPhrasesLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        configure()
        setUpLabel("hi")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        self.backgroundColor = .systemGray
    }
}

private extension FrequentlyUsedPhrasesView {
    func setUpLabel(_ text: String) {
        for i in 0..<3 {
            let label = UILabel()
            //MockData
            label.text = text
            label.textAlignment = .left
            
            addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
            if i == 0 {
                label.topAnchor.constraint(equalTo: topAnchor).isActive = true
            } else {
                let previousLabel = subviews[i - 1]
                label.topAnchor.constraint(equalTo: previousLabel.bottomAnchor).isActive = true
            }
        }
    }
}
