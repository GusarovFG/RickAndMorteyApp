//
//  LoginViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 03.09.2021.
//

import UIKit

class LoginViewController: UIViewController {

    var showPassIcon = true

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonPressing(_ sender: Any) {
        let regularExpressionsForLogin = try? NSRegularExpression(pattern: ("Rick"))
        let regularExpressionsForPassword = try? NSRegularExpression(pattern: "Mortey")
        if  regularExpressionsForLogin?.numberOfMatches(in: loginTextField.text ?? "", range: NSRange(location: 0, length: loginTextField.text?.count ?? 0)) == 0, regularExpressionsForPassword?.numberOfMatches(in: passwordTextField.text ?? "", range: NSRange(location: 0, length: passwordTextField.text?.count ?? 0)) == 0 {
            errorLabel.isHidden = false
            loginTextField.textColor = .red
            passwordTextField.textColor = .red
        } else {
            self.dismiss(animated: true)
        }


    }

    @IBAction func showPassButton(_ sender: UIButton) {
        showPassIcon.toggle()
        passwordTextField.isSecureTextEntry = showPassIcon    }
}
