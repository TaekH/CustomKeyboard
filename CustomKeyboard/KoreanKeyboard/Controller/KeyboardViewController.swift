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
    private let toolbar = ToolbarView()
    
    var shiftKeyState: ShiftKeyState = .normal
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        keyboardView = KeyboardView(.normal, !self.needsInputModeSwitchKey)
        setUpToolBarLayout()
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
        switch key.uniValue {
        case 100:
            advanceToNextInputMode()
        case 101:
            shiftKeyState = shiftKeyState == .normal ? .constant : .normal
            resetKeyboardView()
        case 102: //MARK: 삭제 키
            handleKeyDelete()
            print("key 삭제 이후 delBuffer : ", delBuffer)
            print("key 삭제 이후 buffer : ", buffer)
            print("state : ", state)
        case 103:
            textDocumentProxy.insertText(key.keyword)
            buffer.removeAll()
            state = 0
        case 104:
            textDocumentProxy.insertText(" ")
            buffer.removeAll()
            state = 0
        case 105:
            textDocumentProxy.insertText("\n")
            buffer.removeAll()
            state = 0
        default:
            handleKeyInput(key)
            print("key 삽입 이후 buffer : ", buffer)
            print("key 삽입 이후 delBuffer : ", delBuffer)
            print("state : ", state)
            if shiftKeyState == .constant {
                shiftKeyState = .normal
                resetKeyboardView()
            }
        }
    }
    
    func resetKeyboardView() {
        keyboardView.removeFromSuperview()
        keyboardView = KeyboardView(shiftKeyState, !self.needsInputModeSwitchKey)
        keyboardView.delegate = self
        setUpKeyboardViewLayout()
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

private extension KeyboardViewController {
    
    func makeWord(_ cho: KeyModel, _ jung: KeyModel, _ jong: KeyModel) -> String {
        print(Hangul.chos.contains(cho.keyword), cho)
        print(Hangul.jungs.contains(jung.keyword), jung)
        print(Hangul.jongs.contains(jong.keyword), jong)
        if Hangul.chos.contains(cho.keyword) && Hangul.jungs.contains(jung.keyword) && Hangul.jongs.contains(jong.keyword) {
            guard let result = UnicodeScalar(0xAC00 + 28 * 21 * cho.uniValue + 28 * jung.uniValue  + jong.uniValue) else { return "오류가 발생했습니다." }
            print(String(Character(result)))
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
                    delBuffer += buffer
                    buffer.removeAll()
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
                if doubleJung.keyword != "" { //MARK: 이중 중성이 들어온 경우
                    textDocumentProxy.deleteBackward()
                    textDocumentProxy.insertText(makeWord(chojung[0], doubleJung, invalidKey))
                    buffer.removeLast()
                    buffer.append(doubleJung)
                } else { //MARK: 아닌 경우
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
            print(doubleJong)
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
                if delBuffer.count == 1 { //MARK: "ㅘ" 같은 상황
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
                if buffer.count >= 3 { // 앉 과 같은 상황
                    guard let lastKey = buffer.last else { return }
                    buffer.removeLast()
                    if !Hangul.doublePhonemes.contains(lastKey.keyword) { //이중 종성이 아닌 경우
                        state = 2
                        return
                    }
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
                    if delBuffer.count >= 3 { // 안ㄴ , ㅏㅏㅏㅇ, ㅇㅇㅇ 과 같은 상황
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
                    textDocumentProxy.insertText(lastKey.keyword)
                    state = 1
                } else {
                    textDocumentProxy.insertText(makeWord(lastKey, deleteKeys.0, invalidKey))
                    buffer.append(deleteKeys.0)
                    
                }
                
            }

        default:
            break
        }
    }
}
