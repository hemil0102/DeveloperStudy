import UIKit

class ViewController: UIViewController {
    
    var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        
        // Create Keyboard
        addTextField()
        confirmTextFieldCostraints()
        
        // Hide Keyboard
        self.hideKeyboardWhenTappedAround()
    }
    
    func addTextField() {
        self.view.addSubview(textField)
    }
    
    func confirmTextFieldCostraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textField.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -10).isActive = true
    }
}

// Hide Keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
