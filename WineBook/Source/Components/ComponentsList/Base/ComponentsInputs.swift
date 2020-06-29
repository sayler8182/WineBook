//
//  ComponentsInputs.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsUtils
import FormsValidators
import UIKit

extension ComponentsInputs.textField {
    static func main() -> TitleTextField {
        let component = ComponentsInputs.textField.default()
        component.marginEdgeInset = UIEdgeInsets(
            vertical: 16,
            horizontal: 16)
        return component
    }
}

extension ComponentsInputs.textField.amount {
    static func main() -> TitleTextField {
        let component = ComponentsInputs.textField.main()
        component.keyboardType = .numberPad
        component.textFieldDelegate = TextFieldDelegates.amount()
        return component
    }
}

extension ComponentsInputs.textField.date {
    static func main() -> TitleTextField {
        let component = ComponentsInputs.textField.main()
        component.keyboardType = .numberPad
        component.textFieldDelegate = TextFieldDelegates.format(format: "dd/MM/yyyy", formatChars: Format.dateFormatChars)
        component.maskText = "dd/MM/yyyy"
        return component
    }
}

extension ComponentsInputs.textField.email {
    static func main() -> TitleTextField {
        let component = ComponentsInputs.textField.main()
        component.autocapitalizationType = .none
        component.autocorrectionType = .no
        component.keyboardType = .emailAddress
        component.textFieldDelegate = TextFieldDelegates.email()
        return component
    }
}

extension ComponentsInputs.textField.format {
    static func main() -> TitleTextField {
        let component = ComponentsInputs.textField.main()
        component.textFieldDelegate = TextFieldDelegates.format(format: "", formatChars: Format.defaultFormatChars)
        return component
    }
}

extension ComponentsInputs.textField.password {
    static func main() -> TitleTextField {
        let component = ComponentsInputs.textField.main()
        component.keyboardType = .default
        component.isSecureTextEntry = true
        return component
    }
}

extension ComponentsInputs.textField.pesel {
    static func main() -> TitleTextField {
        let component = ComponentsInputs.textField.main()
        component.keyboardType = .numberPad
        component.textFieldDelegate = TextFieldDelegates.pesel()
        return component
    }
}

extension ComponentsInputs.textField.phone {
    static func main() -> TitleTextField {
        let component = ComponentsInputs.textField.main()
        component.keyboardType = .phonePad
        component.textFieldDelegate = TextFieldDelegates.phone()
        return component
    }
}

extension ComponentsInputs.textField.postCode {
    static func main() -> TitleTextField {
        let component = ComponentsInputs.textField.main()
        component.keyboardType = .numberPad
        component.textFieldDelegate = TextFieldDelegates.format(format: "XX-XXX", formatChars: Format.defaultFormatChars)
        component.maskText = "00-000"
        return component
    }
}

extension ComponentsInputs.textView {
    static func main() -> TitleTextView {
        let component = ComponentsInputs.textView.default()
        component.marginEdgeInset = UIEdgeInsets(
            vertical: 16,
            horizontal: 16)
        return component
    }
}
