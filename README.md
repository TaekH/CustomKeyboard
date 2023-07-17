
# CustomKeyboard
Keyboard Extension 을 활용한 어느 앱에나 사용할 수 있도록 구현한 한글 키보드입니다.

자주쓰는 말, 단축어 기능을 통해서 보다 편하게 키보드를 사용할 수 있습니다.




## Preview
| 한글 조합 입력 | 입력 음소 단위 삭제 | 자주 쓰는 말 | 단축어 |
| --- | --- | --- | --- |
  ![Simulator Screen Recording - iPhone 14 - 2023-07-17 at 12 32 32](https://github.com/TaekH/CustomKeyboard/assets/103012087/0b65862d-7129-4d85-a4b4-f252277b2de1)   |  ![Simulator Screen Recording - iPhone 14 - 2023-07-17 at 12 32 48](https://github.com/TaekH/CustomKeyboard/assets/103012087/ae09c789-c2ef-4ab7-bd29-95a351372867)   |   ![Simulator Screen Recording - iPhone 14 - 2023-07-17 at 12 32 09](https://github.com/TaekH/CustomKeyboard/assets/103012087/9e1761eb-0278-46f0-86be-ac4df08aff89) | ![Simulator Screen Recording - iPhone 14 - 2023-07-17 at 12 33 08](https://github.com/TaekH/CustomKeyboard/assets/103012087/d328e565-f2e2-446d-9ca1-3dcf6a0c342d)     |


## Tech & Skills
- CodeBased UIKit
  - StoryBoard를 사용하지 않고 CodeBase로 UI를 구현하였습니다.
  - UIStackView, UIView 등을 활용하였습니다.
- Keyboard Extension
- MVC
  - Model - View - Controller 로 구성하여
    - View 는 데이터를 표시
    - Controller 는 View에서 받은 이벤트를 처리
    - Model은 데이터를 가공 및 제공합니다.
  - Delegate패턴을 활용하여 View에서 수신한 액션을 Controller에서 처리하도록 하였습니다.


## Folder Structure
```
📦KoreanKeyboard
 ┣ 📂Controller
 ┃ ┗ 📜KeyboardViewController.swift
 ┣ 📂Literal
 ┃ ┣ 📜Hangul.swift
 ┃ ┣ 📜Size.swift
 ┃ ┣ 📜Text.swift
 ┃ ┗ 📜Value.swift
 ┣ 📂Model
 ┃ ┗ 📜KeyModel.swift
 ┣ 📂View
 ┃ ┣ 📂FrequentlyUsedPhrasesView
 ┃ ┃ ┣ 📂Components
 ┃ ┃ ┃ ┣ 📜FrequentlyUsedPhrasesButton.swift
 ┃ ┃ ┃ ┗ 📜FrequentlyUsedPhrasesLabel.swift
 ┃ ┃ ┣ 📜FrequentlyUsedPhrasesView.swift
 ┃ ┃ ┗ 📜ToolbarView.swift
 ┃ ┣ 📂KeyboardView
 ┃ ┃ ┣ 📂Components
 ┃ ┃ ┃ ┣ 📜KeyButton.swift
 ┃ ┃ ┃ ┗ 📜PaddingView.swift
 ┃ ┃ ┗ 📜KeyboardView.swift
 ┃ ┣ 📂ShortCutsView
 ┃ ┃ ┣ 📂Components
 ┃ ┃ ┃ ┗ 📜ShortCutButtons.swift
 ┃ ┃ ┗ 📜ShortCutsView.swift
 ┗ 📜Info.plist
```
