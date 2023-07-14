//
//  KeyboardView.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/11.
//

import UIKit

protocol KeyboardViewDelegate: AnyObject {
    func setKeyAction(key: KeyModel)
}

class KeyboardView: UIView {
    
    lazy var keyboardStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Size.keyRowSpacing
        stackView.backgroundColor = .darkGray
        stackView.layoutMargins = Size.keyboardEdgeInsets()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    weak var delegate: KeyboardViewDelegate?
    var shiftState: ShiftKeyState
    var switchKeyState: Bool
    
    init(_ shiftState: ShiftKeyState, _ switchKeyState: Bool) {
        self.shiftState = shiftState
        self.switchKeyState = switchKeyState
        super.init(frame: .zero)
        setUpKeyboardStackView()
        setUpKeyboardStackViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpRowStackView(keyRow: [KeyModel]) -> UIStackView {
        let rowStackView = UIStackView()
        rowStackView.axis = .horizontal
        rowStackView.spacing = Size.keyItemSpacing
        rowStackView.distribution = keyRow.count <= 4 ? .fillProportionally : .equalSpacing
        rowStackView.alignment = .fill
        
        keyRow.forEach { key in
            let keyButton = shiftState == .constant ? KeyButton(key: getConstantKey(key)) : KeyButton(key: key)
            keyButton.addTarget(self, action: #selector(keyButtonPressed), for: .touchUpInside)
            
            switch key.uniValue {
            case 0..<100:
                keyButton.widthAnchor.constraint(equalToConstant: Size.keyWidth).isActive = true
                keyButton.heightAnchor.constraint(equalToConstant: Size.keyWidth * 1.35).isActive = true
            case 101:
                keyButton.widthAnchor.constraint(equalToConstant: Size.keyWidth * 2).isActive = true
                var shiftButtonConfig = UIButton.Configuration.filled()
                shiftButtonConfig.baseBackgroundColor = shiftState == .constant ? .white : .systemGray
                shiftButtonConfig.baseForegroundColor = shiftState == .constant ? .systemGray : .white
                keyButton.configuration = shiftButtonConfig
            case 100:
                keyButton.isHidden = switchKeyState
            default: break
            }
            if key.keyword == "ㅁ" {
                let paddingView = PaddingView(keyRow.count)
                rowStackView.addArrangedSubview(paddingView)
            }
            rowStackView.addArrangedSubview(keyButton)
            if key.keyword == "ㅣ" {
                let paddingView = PaddingView(keyRow.count)
                rowStackView.addArrangedSubview(paddingView)
            }
        }
        return rowStackView
    }
    
    private func setUpKeyboardStackView() {
        for row in keys {
            let rowView = setUpRowStackView(keyRow: row)
            keyboardStackView.addArrangedSubview(rowView)
        }
    }
    
    @objc func keyButtonPressed(_ sender: KeyButton) {
        delegate?.setKeyAction(key: sender.keyValue)
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
