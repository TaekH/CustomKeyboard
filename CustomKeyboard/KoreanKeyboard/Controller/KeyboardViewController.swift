//
//  KeyboardViewController.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/11.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    private var keyboardView: KeyboardView!
    
    var shiftKeyState: ShiftKeyState = .normal
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        setUpKeyboardViewLayout()
        keyboardView.delegate = self
        // Perform custom UI setup here
    }
    
    override func viewWillLayoutSubviews() {
        //self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
    }

}

extension KeyboardViewController: KeyboardViewDelegate {
    
    func setKeyAction(key: KeyModel) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        switch key.uniValue {
        case 101:
            shiftKeyState = shiftKeyState == .normal ? .constant : .normal
            resetKeyboardView()
        case 100:
            advanceToNextInputMode()
        default:
            proxy.insertText(key.keyword)
            shiftKeyState = .normal
            resetKeyboardView()
        }
    }
    
    func resetKeyboardView() {
        keyboardView.removeFromSuperview()
        keyboardView = KeyboardView(shiftKeyState, !self.needsInputModeSwitchKey)
        keyboardView.delegate = self
        setUpKeyboardViewLayout()
    }
}

private extension KeyboardViewController {
    func setUpKeyboardViewLayout() {
        keyboardView = KeyboardView(.normal, !self.needsInputModeSwitchKey)
        view.addSubview(keyboardView)
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            keyboardView.topAnchor.constraint(equalTo: view.topAnchor),
            keyboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
