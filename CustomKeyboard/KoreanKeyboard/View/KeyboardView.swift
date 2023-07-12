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
        stackView.spacing = Size.keyboardRowSpacing(CGFloat(keys.count))
        stackView.backgroundColor = .darkGray
        stackView.layoutMargins = Size.keyboardEdgeInsets()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.distribution = .fillEqually
        return stackView
    }()
    
//    let keyButton: (String) -> UIButton = { title in
//        let button = UIButton(type: .system)
//        button.setTitle(title, for: .normal)
//        button.titleLabel?.adjustsFontSizeToFitWidth = true
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
//        button.backgroundColor = .systemGray
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = Size.keyRadius
//        button.widthAnchor.constraint(equalToConstant: Size.keyWidth).isActive = true
//        button.heightAnchor.constraint(equalToConstant: Size.keyHeight).isActive = true
//        return button
//    }
    
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
        rowStackView.spacing = Size.keyboardItemSpacing(Size.keyWidth, CGFloat(keys.first?.count ?? 10))
         rowStackView.distribution = .fillEqually
        rowStackView.alignment = .center
         
        keyRow.forEach { key in
            let button = KeyButton(key.keyword)
            rowStackView.addArrangedSubview(button)
        }
         
         return rowStackView
     }
    
    private func setUpKeyboardStackView() {
        for row in keys {
            let rowStackView = setUpRowStackView(keyRow: row)
            keyboardStackView.addArrangedSubview(rowStackView)
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
