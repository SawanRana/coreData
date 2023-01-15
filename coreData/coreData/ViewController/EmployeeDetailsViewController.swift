//
//  EmployeeDetailsViewController.swift
//  coreData
//
//  Created by Sawan Rana on 13/01/23.
//

import UIKit

class EmployeeDetailsViewController: UIViewController {
    
    var model: EmployeeModel = EmployeeModel()

    @IBOutlet weak var contentView: UIView! {
        didSet {
            contentView.backgroundColor = .clear
            gradient = contentView.setupGradient([UIColor.white, UIColor.green.withAlphaComponent(1), UIColor.black.withAlphaComponent(0.8), UIColor.clear])
        }
    }
    
    @IBOutlet weak var seeEmployeeListButton: UIButton! {
        didSet {
            seeEmployeeListButton.layer.cornerRadius = createButton.frame.height/2
            seeEmployeeListButton.backgroundColor = UIColor.systemBlue
            seeEmployeeListButton.setAttributedTitle(NSAttributedString(string: "See Employee(s)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        }
    }
    
    @IBOutlet weak var createButton: UIButton! {
        didSet {
            createButton.layer.cornerRadius = createButton.frame.height/2
            createButton.backgroundColor = UIColor.systemBlue
            createButton.setAttributedTitle(NSAttributedString(string: "Create Employee", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var dlTF: UITextField!
    @IBOutlet weak var placeOfIssueTF: UITextField!
    
    var keyboardPresent: Bool = false
    
    private var employeeManager = EmployeeManager()
    private var gradient: CAGradientLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Employee Details"
        // Do any additional setup after loading the view.
        configure()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
        seeEmployeeListButton.isHidden = employeeManager.readAllEmployee()?.isEmpty ?? true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient?.frame = contentView.bounds
    }
    
    @IBAction func createEmployeeAction(_ sender: UIButton) {
        guard let name = nameTF.text, let age = ageTF.text, !name.isEmpty, !age.isEmpty, let email = emailTF.text, !email.isEmpty else {
            return
        }
        
        if let dlText = dlTF.text, let pofText = placeOfIssueTF.text, dlText.isEmpty && !pofText.isEmpty {
            placeOfIssueTF.text = ""
            dismissKeyboard()
            displayAlert()
            return
        }

        let dlInfo = DL(id: UUID(), drivingLicenseId: dlTF.text ?? "", placeOdfIssue: placeOfIssueTF.text ?? "")
        
        employeeManager.create(employee: Employee(id: UUID(), name: name, age: Int16(age) ?? 0, email: email, dl: dlInfo))
        
        clearTextFields()
        performSegue(withIdentifier: "navigateToEmployeesList", sender: nil)
    }
    
    @IBAction func seeEmployeeAction(_ sender: UIButton) {
        performSegue(withIdentifier: "navigateToEmployeesList", sender: nil)
    }
    
    private func configure() {
        imageView.image = UIImage(systemName: "pencil.circle.fill")
        hideKeyboardOnTap()
        addPickerView()
    }
    
    private func displayAlert() {
        let alertController = UIAlertController(title: "OK!", message: "Please mention driving license for issue place too!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .destructive))
        self.present(alertController, animated: true)
    }
    
    private func clearTextFields() {
        nameTF.text = ""
        ageTF.text = ""
        emailTF.text = ""
        dlTF.text = ""
        placeOfIssueTF.text = ""
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navigateToEmployeesList" {
            self.tabBarController?.tabBar.isHidden = true
        }
    }

}

class MyToolBar {
    
    static let shared = MyToolBar()
    
    private init() {}
    
    func getToolBar(handler: Selector) -> UIToolbar {
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: handler)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
        toolbar.setItems([spaceButton, doneButton], animated: true)
        return toolbar
    }
    
}
