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

    @IBOutlet weak var ImageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonBottonConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var gifImage: UIImageView!
    @IBOutlet weak var headGifImage: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            self.ImageViewTopConstraint.constant = 20
            self.buttonBottonConstraint.constant = 30
        } else {
            self.ImageViewTopConstraint.constant = 134
            self.buttonBottonConstraint.constant = 50
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.gifImage.frame.origin.y = -100
        self.headGifImage.frame.origin.x = 0
        self.headGifImage.frame.origin.y = 100
        self.headGifImage.alpha = 0
        self.headGifImage.frame.size = CGSize(width: 0, height: 0)
        UIView.animate(withDuration: 3) {
            self.gifImage.frame.origin.y = 1000
        }
        UIView.animate(withDuration: 10) {
            self.headGifImage.frame.origin.y = 300
            self.headGifImage.frame.origin.x = 300
            self.headGifImage.frame.size = CGSize(width: 500, height: 500)
            self.headGifImage.alpha = 1
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.gifImage.loadGif(asset: "giphy")
        self.headGifImage.loadGif(asset: "giphy (3)")
        self.passwordToggleButton()
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
            self.errorLabel.isHidden = false
            self.loginTextField.textColor = .red
            self.passwordTextField.textColor = .red
        }
    }

    @objc private func showPassButton() {

        self.showPassIcon.toggle()
        self.passwordTextField.isSecureTextEntry = showPassIcon

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
