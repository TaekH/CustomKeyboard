//
//  KeyboardViewController.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/11.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    var buffer = [KeyModel]()
    var delBuffer = [KeyModel]()
    let invalidKey = KeyModel(keyword: "", uniValue: 0)
    var state: Int = 0
    
    private var keyboardView: KeyboardView!
    private var frequentlyUsedPhrasesView: FrequentlyUsedPhrasesView!
    private var shortCutsView: ShortCutsView!
    private let toolbar = ToolbarView()
    
    private var shiftKeyState: ShiftKeyState = .normal
    private var shortCutTitle: String = "단축키"
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        keyboardView = KeyboardView(.normal, !self.needsInputModeSwitchKey, shortCutTitle)
        keyboardView.delegate = self
        
        setUpToolBarLayout()
        setUpKeyboardViewLayout()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
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
    
    func resetShiftState() {
        if shiftKeyState == .constant {
            shiftKeyState = .normal
            resetKeyboardView()
        }
    }
    
    func resetState() {
        buffer.removeAll()
        delBuffer.removeAll()
        state = 0
    }
    
    func setKeyAction(key: KeyModel) {
        switch key.uniValue {
        case 100:
            advanceToNextInputMode()
        case 101:
            shiftKeyState = shiftKeyState == .normal ? .constant : .normal
            resetKeyboardView()
        case 102:
            handleKeyDelete()
            resetShiftState()
        case 103:
            textDocumentProxy.insertText(shortCutTitle)
            resetState()
            resetShiftState()
        case 104:
            textDocumentProxy.insertText(" ")
            resetState()
            resetShiftState()
        case 105:
            textDocumentProxy.insertText("\n")
            resetState()
            resetShiftState()
        default:
            handleKeyInput(key)
            resetShiftState()
        }
    }
    
    func resetKeyboardView() {
        keyboardView.removeFromSuperview()
        keyboardView = KeyboardView(shiftKeyState, !self.needsInputModeSwitchKey, shortCutTitle)
        keyboardView.delegate = self
        setUpKeyboardViewLayout()
    }
    
    func showShortCutsView() {
        shortCutsView = ShortCutsView()
        view.addSubview(shortCutsView)
        shortCutsView.delegate = self
        shortCutsView.translatesAutoresizingMaskIntoConstraints = false
        shortCutsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Size.keyWidth).isActive = true
        shortCutsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Size.keyWidth * 1.5).isActive = true
        shortCutsView.widthAnchor.constraint(equalToConstant: Size.keyWidth * 3).isActive = true
    }
}

extension KeyboardViewController: ToolbarViewDelegate {
    func setFrequentlyUsedPhrasesView(_ isSelected: Bool) {
        if isSelected {
            setUpFrequentlyUsedPhrasesViewLayout()
            frequentlyUsedPhrasesView.delegate = self
        } else {
            frequentlyUsedPhrasesView.removeFromSuperview()
        }
    }
}

extension KeyboardViewController: FrequentlyUsedPhrasesViewDelegate {
    func setFrequentlyUsedPhrases(_ text: String) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText(text)
    }
}

extension KeyboardViewController: ShortCutsViewDelegate {
    func setShortCutTitle(with title: String) {
        shortCutTitle = title
        resetKeyboardView()
        
        shortCutsView?.removeFromSuperview()
        shortCutsView = nil
    }
}

private extension KeyboardViewController {
    
    func makeWord(_ cho: KeyModel, _ jung: KeyModel, _ jong: KeyModel) -> String {
        if Hangul.chos.contains(cho.keyword) && Hangul.jungs.contains(jung.keyword) && Hangul.jongs.contains(jong.keyword) {
            guard let result = UnicodeScalar(0xAC00 + 28 * 21 * cho.uniValue + 28 * jung.uniValue  + jong.uniValue) else { return "" }
            return String(Character(result))
        }
        return ""
    }
    
    func handleKeyInput(_ key: KeyModel) {
        if key.uniValue > 100 {
            textDocumentProxy.insertText(key.keyword)
            return
        }
        
        switch state {
        case 0:
            if Hangul.jungs.contains(key.keyword) {
                guard let firstJung = buffer.last else {
                    textDocumentProxy.insertText(key.keyword)
                    buffer.append(key)
                    return
                }
                let doubleJung = Hangul.makeJungDoublePhoneme(firstJung, key).keyword
                if doubleJung != "" {
                    textDocumentProxy.deleteBackward()
                    textDocumentProxy.insertText(doubleJung)
                    buffer.append(key)
                    delBuffer += buffer
                    buffer.removeAll()
                }
                else {
                    textDocumentProxy.insertText(key.keyword)
                    delBuffer += buffer
                    buffer.removeAll()
                    buffer.append(key)
                }
            } else {
                textDocumentProxy.insertText(key.keyword)
                delBuffer += buffer
                buffer.removeAll()
                buffer.append(key)
                state = 1
            }
        case 1:
            if Hangul.jungs.contains(key.keyword) {
                guard let lastKey = buffer.last else { return }
                let lastKeys = Hangul.breakJongDoublePhoneme(lastKey)
                if buffer.count <= 2 {
                    textDocumentProxy.deleteBackward()
                    textDocumentProxy.insertText(makeWord(lastKey, key, invalidKey))
                } else {
                    textDocumentProxy.deleteBackward()
                    let chojungjong = Array(buffer.suffix(3))
                    buffer.removeLast()
                    buffer.append(lastKeys.0)
                    textDocumentProxy.insertText(makeWord(chojungjong[0], chojungjong[1], lastKeys.0))
                    textDocumentProxy.insertText(makeWord(Hangul.breakJongDoublePhoneme(lastKeys.1).0, key, invalidKey))
                    buffer.append(lastKeys.1)
                }
                buffer.append(key)
                state = 2
            } else {
                textDocumentProxy.insertText(key.keyword)
                delBuffer += buffer
                buffer.removeAll()
                buffer.append(key)
            }
        case 2:
            let chojung = Array(buffer.suffix(2))
            if Hangul.jungs.contains(key.keyword) {
                let doubleJung = Hangul.makeJungDoublePhoneme(chojung[1], key)
                if doubleJung.keyword != "" {
                    textDocumentProxy.deleteBackward()
                    textDocumentProxy.insertText(makeWord(chojung[0], doubleJung, invalidKey))
                    buffer.removeLast()
                    buffer.append(doubleJung)
                } else {
                    buffer.append(key)
                    delBuffer += buffer
                    buffer.removeAll()
                    textDocumentProxy.insertText(key.keyword)
                    state = 0
                }
            } else {
                textDocumentProxy.deleteBackward()
                textDocumentProxy.insertText(makeWord(chojung[0], chojung[1], Hangul.makeJongDoublePhoneme(key, invalidKey)))
                buffer.append(key)
                state = 3
            }
        case 3:
            let chojungjong = Array(buffer.suffix(3))
            let doubleJong = Hangul.makeJongDoublePhoneme(chojungjong[2], key)
            if doubleJong.keyword != "" {
                textDocumentProxy.deleteBackward()
                textDocumentProxy.insertText(makeWord(chojungjong[0], chojungjong[1], doubleJong))
                buffer.removeLast()
                buffer.append(doubleJong)
                state = 1
            }
            else if Hangul.chos.contains(key.keyword) {
                delBuffer += buffer
                buffer.removeAll()
                state = 1
                textDocumentProxy.insertText(key.keyword)
                buffer.append(key)
            } else if Hangul.jungs.contains(key.keyword) {
                guard let cho = buffer.last else { return }
                let chojungjong = Array(buffer.suffix(3))
                textDocumentProxy.deleteBackward()
                textDocumentProxy.insertText(makeWord(chojungjong[0], chojungjong[1], invalidKey))
                textDocumentProxy.insertText(makeWord(cho, key, invalidKey))
                state = 2
                buffer.append(key)
            }
            
        default:
            break
        }
    }
}


extension KeyboardViewController {
    func getPhonemeType(_ key: KeyModel) -> Int {
        if Hangul.chos.contains(key.keyword) {
            return 1
        } else if Hangul.jungs.contains(key.keyword) {
            return 2
        }
        return 0
    }
    
    func handleKeyDelete() {
        switch state {
        case 0:
            textDocumentProxy.deleteBackward()
            
            if !buffer.isEmpty {
                buffer.removeLast()
            } else if !delBuffer.isEmpty {
                delBuffer.removeLast()
                if delBuffer.count == 1 {
                    textDocumentProxy.insertText(delBuffer.last!.keyword)
                    return
                } else if delBuffer.count >= 2 {
                    let keys = Array(delBuffer.suffix(2))
                    let word = makeWord(keys[0], keys[1], invalidKey)
                    if word != "" {
                        state = 2
                    }
                }
            }
            
        case 1:
            textDocumentProxy.deleteBackward()
            
            if !buffer.isEmpty {
                if buffer.count >= 3 {
                    guard let lastKey = buffer.last else { return }
                    buffer.removeLast()
                    let lastKeys = Hangul.breakJongDoublePhoneme(lastKey)
                    buffer.append(lastKeys.0)
                    let lastThreeKeys = Array(buffer.suffix(3))
                    let word = makeWord(lastThreeKeys[0], lastThreeKeys[1], lastThreeKeys[2])
                    if word != "" {
                        textDocumentProxy.insertText(word)
                        state = 3
                    }
                } else if !delBuffer.isEmpty {
                    buffer.removeLast()
                    if delBuffer.count >= 3 {
                        let lastThreeKeys = Array(delBuffer.suffix(3))
                        if makeWord(lastThreeKeys[0], lastThreeKeys[1], lastThreeKeys[2]) != "" {
                            buffer += lastThreeKeys
                            delBuffer.removeLast(3)
                            state = Hangul.breakJongDoublePhoneme(lastThreeKeys[2]).1.keyword != "" ? 1 : 3
                        } else {
                            let lastKey = delBuffer.last!
                            if Hangul.chos.contains(lastKey.keyword) {
                                delBuffer.removeLast()
                                buffer.append(lastKey)
                                state = 1
                            } else { state = 0 }
                        }
                    } else {
                        let lastKey = delBuffer.last!
                        delBuffer.removeLast()
                        if Hangul.chos.contains(lastKey.keyword) {
                            buffer.append(lastKey)
                            state = 1
                        } else { state = 0 }
                    }
                } else {
                    buffer.removeLast()
                    state = 0
                }
            }
            
        case 2:
            textDocumentProxy.deleteBackward()
            if !buffer.isEmpty {
                guard let deleteKey = buffer.last else { return }
                buffer.removeLast()
                guard let lastKey = buffer.last else { return }
                let deleteKeys = Hangul.breakJungDoublePhoneme(deleteKey)
                if deleteKeys.0.keyword == "" {
                    if buffer.count == 3 {
                        let lastThreeKeys = Array(buffer.suffix(3))
                        let word = makeWord(lastThreeKeys[0], lastThreeKeys[1], Hangul.makeJongDoublePhoneme(lastThreeKeys[2], invalidKey))
                        if word != "" {
                            textDocumentProxy.deleteBackward()
                            textDocumentProxy.insertText(word)
                            state = 3
                        }
                    }
                    else if buffer.count >= 4 {
                        let lastFourKeys = Array(buffer.suffix(4))
                        let doubleJong = Hangul.makeJongDoublePhoneme(lastFourKeys[2], lastFourKeys[3])
                        let word = makeWord(lastFourKeys[0], lastFourKeys[1], doubleJong)
                        buffer.removeLast(2)
                        buffer.append(doubleJong)
                        if word != "" {
                            textDocumentProxy.deleteBackward()
                            textDocumentProxy.insertText(word)
                            state = 1
                        }
                        
                    }
                    else {
                        textDocumentProxy.insertText(lastKey.keyword)
                        state = 1
                    }
                } else {
                    textDocumentProxy.insertText(makeWord(lastKey, deleteKeys.0, invalidKey))
                    buffer.append(deleteKeys.0)
                }
            }
            
        case 3:
            textDocumentProxy.deleteBackward()
            if !buffer.isEmpty {
                buffer.removeLast()
                let lastTwoKeys = Array(buffer.suffix(2))
                textDocumentProxy.insertText(makeWord(lastTwoKeys[0], lastTwoKeys[1], invalidKey))
                state = 2
            }
            
        default:
            break
        }
    }
}

private extension KeyboardViewController {
    func setUpToolBarLayout() {
        toolbar.delegate = self
        view.addSubview(toolbar)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolbar.topAnchor.constraint(equalTo: view.topAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: Size.toolbarHeight)
        ])
    }
    
    func setUpKeyboardViewLayout() {
        view.addSubview(keyboardView)
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            keyboardView.topAnchor.constraint(equalTo: toolbar.bottomAnchor),
            keyboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setUpFrequentlyUsedPhrasesViewLayout() {
        frequentlyUsedPhrasesView = FrequentlyUsedPhrasesView()
        view.addSubview(frequentlyUsedPhrasesView)
        frequentlyUsedPhrasesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            frequentlyUsedPhrasesView.topAnchor.constraint(equalTo: toolbar.bottomAnchor),
            frequentlyUsedPhrasesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            frequentlyUsedPhrasesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            frequentlyUsedPhrasesView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

