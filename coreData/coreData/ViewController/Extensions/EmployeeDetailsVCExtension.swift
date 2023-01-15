//
//  EmployeeDetailsVCExtension.swift
//  coreData
//
//  Created by Sawan Rana on 15/01/23.
//

import Foundation
import UIKit

extension EmployeeDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.model.placeName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.model.placeName[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.placeOfIssueTF.text = self.model.placeName[row]
    }
    
}

extension EmployeeDetailsViewController {
    func hideKeyboardOnTap() {
        let tapGuesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGuesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGuesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension EmployeeDetailsViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardPresent == false {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                
                UIView.animate(withDuration: 1.0) {
                    self.view.frame.origin.y -= keyboardSize.height/4
                } completion: { success in
                    self.keyboardPresent = success
                }
            }
        } 
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.keyboardPresent = false
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }
    }
}
