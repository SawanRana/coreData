//
//  EmployeeUpdateViewController.swift
//  coreData
//
//  Created by Sawan Rana on 13/01/23.
//

import UIKit

enum Operation {
    case update
    case delete
}

class EmployeeUpdateViewController: UIViewController {
    
    var model: EmployeeModel = EmployeeModel()
    var selectedEmployee: Employee? = nil
    var keyboardPresent: Bool = false

    @IBOutlet weak var contentView: UIView! {
        didSet {
            contentView.backgroundColor = .clear
            gradient = contentView.setupGradient([UIColor.white, UIColor.green.withAlphaComponent(1)])
        }
    }
    
    @IBOutlet weak var deleteButton: UIButton! {
        didSet {
            deleteButton.layer.cornerRadius = deleteButton.frame.height/2
            deleteButton.backgroundColor = UIColor.systemRed
            deleteButton.setAttributedTitle(NSAttributedString(string: "Delete Employee", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        }
    }
    
    @IBOutlet weak var updateButton: UIButton! {
        didSet {
            updateButton.layer.cornerRadius = updateButton.frame.height/2
            updateButton.backgroundColor = UIColor.systemBlue
            updateButton.setAttributedTitle(NSAttributedString(string: "Update Employee", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var dlTF: UITextField!
    @IBOutlet weak var placeOfIssueTF: UITextField!
    
    private var employeeManager = EmployeeManager()
    private var dlManager = DrivingLicenseManager()
    private var gradient: CAGradientLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Employee Details"
        // Do any additional setup after loading the view.
        configure()
        updateTextFields()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient?.frame = contentView.bounds
    }
    
    @IBAction func updateEmployeeAction(_ sender: UIButton) {
        guard let name = nameTF.text, let age = ageTF.text, !name.isEmpty, !age.isEmpty, let email = emailTF.text, !email.isEmpty else {
            return
        }
        
        if let dlText = dlTF.text, let pofText = placeOfIssueTF.text, dlText.isEmpty && !pofText.isEmpty {
            placeOfIssueTF.text = ""
            dismissKeyboard()
            displayAlert()
            return
        }
        
        if let selectedEmployee = selectedEmployee {
            let dlInfo = DL(id: selectedEmployee.dl?.id ?? UUID(), drivingLicenseId: dlTF.text ?? "", placeOdfIssue: selectedEmployee.dl?.placeOdfIssue ?? "")
            let updatedEmployee = Employee(id: selectedEmployee.id, name: name, age: Int16(age) ?? 0, email: email, dl: dlInfo)
            displayAlert(successful: employeeManager.update(employee: updatedEmployee), operation: .update)
        }
    }
    
    @IBAction func deleteEmployeeAction(_ sender: UIButton) {
        guard let name = nameTF.text, let age = ageTF.text, !name.isEmpty, !age.isEmpty, let email = emailTF.text, !email.isEmpty else {
            return
        }
        
        if let selectedEmployee = selectedEmployee {
            displayAlert(successful: employeeManager.delete(id: selectedEmployee.id), operation: .delete)
        }
    }
    
    private func configure() {
        imageView.image = UIImage(systemName: "pencil.circle.fill")
        hideKeyboardOnTap()
        addPickerView()
    }
    
    private func displayAlert() {
        let alertController = UIAlertController(title: "OK!", message: "Driving license can't be empty!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .destructive))
        self.present(alertController, animated: true)
    }
    
    private func updateTextFields() {
        nameTF.text = selectedEmployee?.name
        ageTF.text = "\(selectedEmployee?.age ?? 0)"
        emailTF.text = selectedEmployee?.email
        dlTF.text = selectedEmployee?.dl?.drivingLicenseId
        placeOfIssueTF.text = selectedEmployee?.dl?.placeOdfIssue
    }
    
    private func resetTextFields() {
        nameTF.text = ""
        ageTF.text = ""
        emailTF.text = ""
    }
    
    private func displayAlert(successful: Bool, operation: Operation) {
        var title: String = ""
        var msg: String = ""
        
        switch operation {
        case .update:
            title = "Employee updated"
            msg = successful ? "Successfully" : "Error in updating"
        case .delete:
            title = "Employeed deleted"
            msg = successful ? "Successfully" : "Error in deleting"
        }
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .destructive))
        self.present(alertController, animated: true)
    }
    
    private func addPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        placeOfIssueTF.inputView = pickerView
        
        addToolBar()
    }
    
    private func addToolBar() {
        let toolbar = MyToolBar.shared.getToolBar(handler: #selector(dismissKeyboard))
        placeOfIssueTF.inputAccessoryView = toolbar
        nameTF.inputAccessoryView = toolbar
        ageTF.inputAccessoryView = toolbar
        emailTF.inputAccessoryView = toolbar
        dlTF.inputAccessoryView = toolbar
    }

}
