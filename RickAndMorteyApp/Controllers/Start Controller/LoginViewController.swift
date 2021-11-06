//
//  LoginViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 03.09.2021.
//

import UIKit

class LoginViewController: UIViewController {

    private var showPassIcon = true


    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()

        passwordToggleButton()
        self.errorLabel.isHidden = true
    }

    @IBAction func loginButtonPressing(_ sender: Any) {

        //        let regularExpressionsForLogin = try? NSRegularExpression(pattern: ("Rick"))
        //        let regularExpressionsForPassword = try? NSRegularExpression(pattern: "Mortey")
        //
        //        if  regularExpressionsForLogin?.numberOfMatches(in: loginTextField.text ?? "", range: NSRange(location: 0, length: loginTextField.text?.count ?? 0)) == 0, regularExpressionsForPassword?.numberOfMatches(in: passwordTextField.text ?? "", range: NSRange(location: 0, length: passwordTextField.text?.count ?? 0)) == 0 {
        //            errorLabel.isHidden = false
        //            loginTextField.textColor = .red
        //            passwordTextField.textColor = .red
        //        } else {
        //            self.dismiss(animated: true)
        //        }
        if KeyChainManager.shared.checkLoginCredentials(login: loginTextField.text ?? "", password: passwordTextField.text ?? ""){
            self.dismiss(animated: true)
        } else {
            errorLabel.isHidden = false
            loginTextField.textColor = .red
            passwordTextField.textColor = .red
        }


    }

    @objc private func showPassButton() {

        showPassIcon.toggle()
        passwordTextField.isSecureTextEntry = showPassIcon

    }

    private func passwordToggleButton() {
        let button = UIButton()

        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.frame = CGRect(x: CGFloat(self.passwordTextField.frame.size.width - 20), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(showPassButton), for: .touchUpInside)
        button.tintColor = .black

        self.passwordTextField.rightViewMode = .always
        self.passwordTextField.rightView = button
        


    }

}

extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
