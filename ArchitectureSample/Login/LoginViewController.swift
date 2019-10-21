//
//  ViewController.swift
//  ArchitectureSample
//
//  Created by Catalina Turlea on 10/12/19.
//  Copyright © 2019 Catalina Turlea. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // Outlets
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    private let viewModel: LoginViewModelProtocol = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPressed() {
        login(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
//    func login(email: String, password: String, completion: ((Bool) -> Void)) {
//        let authenticationService = AuthenticationService()
//        authenticationService.login(email: email, password: password, { (success, error) in
//            guard let error = error else {
//                // Show the next ViewController
//                return
//            }
//
//            // Show alert for error
//        })
//
//        if email.isEmpty || password.isEmpty {
//            // Show an alert
//            return
//        } else if !isValidEmail(email) {
//            // Show another alert
//            return
//        }
//
//        Alamofire.shared.request("https://my.app.com/login",
//                                 method: .POST,
//                                 parameters: nil,
//                                 encoding: .URLEncoding).responseJSON { (response) in
//            switch respose.status {
//            case .succeeded:
//            // Show the next ViewController
//
//            case .error(let error):
//                // Show an alert depending on the error you got
//            }
//        }
//    }
    
//    func login(email: String, password: String) {
//
//        if email.isEmpty || password.isEmpty {
//            // Show an alert
//            return
//        } else if !isValidEmail(email) {
//            // Show another alert
//            return
//        }
//
//        let authenticationService = AuthenticationService()
//        authenticationService.login(email: email, password: password, completion: { (success, error) in
//            guard let error = error else {
//                // Show the next ViewController
//                return
//            }
//
//            // Show alert for error
//        })
//    }
    
    func login(email: String, password: String) {
        viewModel.login(email: email, password: password) { (success, loginError) in
            guard let error = loginError else {
                // Show the next ViewController
                return
            }
            switch error {
            case .emptyFields:
                // Highlight empty fields
                self.showAlert("Please fill in the fields")
            case .invalidEmail:
                // Prompt user for valid email
                self.showAlert("Please use a valid email")
            case .invalidCredentials:
                // Inform the user the credentials are wrong
                self.showAlert("We could not log you in", message: "Please try again")
            case .noInternet:
                // No login without internet
                self.showAlert("You have no internet connection", message: "Please try again later")
            case .generic:
                // Maybe offer an alternative or a contact option
                self.showAlert("We could not log you in", message: "Please try again")
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        return true
    }
}

