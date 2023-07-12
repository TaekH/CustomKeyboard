//
//  KeyboardView.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/11.
//

import UIKit

class KeyboardView: UIView {
    
    lazy var keyboardStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.backgroundColor = .darkGray
        stackView.layoutMargins = Size.keyboardEdgeInsets()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpKeyboardStackView()
        setUpKeyboardStackViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpRowStackView(keyRow: [KeyModel]) -> UIStackView {
        let rowStackView = UIStackView()
        rowStackView.axis = .horizontal
        rowStackView.spacing = 0
        rowStackView.distribution = keyRow.count <= 4 ? .fillProportionally : .equalSpacing
        rowStackView.alignment = .fill
        
        let paddingView = UIView()
        paddingView.widthAnchor.constraint(equalToConstant: (Size.width - Size.keyWidth * CGFloat(keyRow.count)) / 2).isActive = true
        
        keyRow.forEach { key in
            let button = KeyButtonView(key.keyword)
            if key.uniValue < 100{
                button.widthAnchor.constraint(equalToConstant: Size.keyWidth).isActive = true
                button.heightAnchor.constraint(equalToConstant: Size.keyWidth * 1.35).isActive = true
            }
            rowStackView.addArrangedSubview(button)
        }
        
        return rowStackView
    }
    
    private func setUpRowView(keyRow: [KeyModel]) -> UIView {
        let keyboardRowView = UIView()
        let leadingSpacing = (Size.width - Size.keyWidth * CGFloat(keyRow.count)) / 2
        keyboardRowView.widthAnchor.constraint(equalToConstant: Size.width).isActive = true
        
        var firstKeyView: KeyButtonView?
        keyRow.forEach { key in
            let keyButtonView = KeyButtonView(key.keyword)
            keyboardRowView.addSubview(keyButtonView)
            keyButtonView.translatesAutoresizingMaskIntoConstraints = false
            
            if let firstKeyView = firstKeyView {
                keyButtonView.leadingAnchor.constraint(equalTo: firstKeyView.trailingAnchor).isActive = true
            } else {
                keyButtonView.leadingAnchor.constraint(equalTo: keyboardRowView.leadingAnchor, constant: leadingSpacing).isActive = true
            }
            keyButtonView.topAnchor.constraint(equalTo: keyboardRowView.topAnchor).isActive = true
            keyButtonView.bottomAnchor.constraint(equalTo: keyboardRowView.bottomAnchor).isActive = true
            
            keyButtonView.widthAnchor.constraint(equalToConstant: Size.keyWidth).isActive = true
            keyButtonView.heightAnchor.constraint(equalToConstant: Size.keyWidth * 1.35).isActive = true
            
            firstKeyView = keyButtonView
        }
        return keyboardRowView
    }
    
    
    private func setUpKeyboardStackView() {
        for row in keys {
            let rowView = row.contains { key in
                key.keyword == "ㅁ"
            } ? setUpRowView(keyRow: row) : setUpRowStackView(keyRow: row)
            keyboardStackView.addArrangedSubview(rowView)
        }
    }
}

private extension KeyboardView {
    private func setUpKeyboardStackViewLayout() {
        addSubview(keyboardStackView)
        keyboardStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            keyboardStackView.topAnchor.constraint(equalTo: topAnchor),
            keyboardStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            keyboardStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            keyboardStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
