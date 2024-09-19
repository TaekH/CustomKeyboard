//
//  PaddingView.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/13.
//

import UIKit

final class PaddingView: UIView {
    var keyItemCount: Int
    
    init(_ keyItemCount: Int) {
        self.keyItemCount = keyItemCount
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PaddingView {
    func setUpPaddingViewLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: Size.firstKeyLeadingSpacing(keyItemCount))
        ])
    }
}
