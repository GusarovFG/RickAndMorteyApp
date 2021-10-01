//
//  LoginViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 03.09.2021.
//

import UIKit

class LoginViewController: UIViewController {

    var showPassIcon = true

    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func showPassButton(_ sender: UIButton) {
        showPassIcon.toggle()
        passwordTextField.isSecureTextEntry = showPassIcon    }
}
