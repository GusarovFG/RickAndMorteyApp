//
//  LoginViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 03.09.2021.
//

import UIKit
import SwiftGifOrigin

class LoginViewController: UIViewController {

    private var showPassIcon = true
    private let userDefaultsManager = UserDefaults.standard


    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var portalImage: UIImageView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordToggleButton()
        self.errorLabel.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        self.view.endEditing(true)
    }

    @IBAction func loginButtonPressing(_ sender: Any) {

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

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue

        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardFrame.height
        } else {
            return
        }

    }

    @objc func keyboardWillHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue

        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        } else {
            return
        }

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
