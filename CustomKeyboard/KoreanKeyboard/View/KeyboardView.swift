//
//  KeyboardView.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/11.
//

import UIKit

class KeyboardView: UIView {
    //MARK: 현재 뷰 크기 반환 계산 프로퍼티
    var height: CGFloat {
        return frame.size.height
    }
    
    var width: CGFloat {
        return frame.size.width
    }
    
    lazy var keyboardStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Size.keyboardRowSpacing(height, Size.keySize(width).1)
        stackView.backgroundColor = .darkGray
        stackView.layoutMargins = Size.keyboardEdgeInsets()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let keyButton: (String) -> UIButton = { title in
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .systemGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = Size.keyRadius
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
