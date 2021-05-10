//
//  UITextFieldExtension.swift
//  WeekdaySearch
//
//  Created by Rustem Supayev on 25.04.2021.
//
//
import UIKit

extension UITextField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }

        let updateText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updateText.count < 2
    }
}
