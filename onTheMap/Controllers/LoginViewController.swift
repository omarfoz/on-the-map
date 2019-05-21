//
//  ViewController.swift
//  onTheMap
//
//  Created by Omar Yahya Alfawzan on 4/21/19.
//  Copyright © 2019 Omar Yahya Alfawzan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
       
        super.viewDidLoad()
         setupActivityIndicator()
         emailTextField.delegate = self
         passwordTextField.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    @IBAction func signup(_ sender: Any) {
        if let url = URL(string: "https://auth.udacity.com/sign-up") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func login(_ sender: Any) {
       
        setUIButton(true)
        UdacityClient.sginin(username: emailTextField.text!, password: passwordTextField.text!, sucssess: {
            UdacityClient.getUserData(success: {
                self.configureLoginButton()
            self.performSegue(withIdentifier: "go", sender: nil)

            }, failure: { (Error) in
                Alert.shared.showFailureFromViewController(viewController: self, message: Error.localizedDescription)
            })
        }) { (Error) in
             Alert.shared.showFailureFromViewController(viewController: self, message: Error.localizedDescription)
                self.setUIButton(false)

                }
}
    func setUIButton(_ flag:Bool){
        performRefereshIndicator(!flag)
        loginButton.isEnabled = !flag
        emailTextField.isEnabled = !flag
        passwordTextField.isEnabled = !flag
        loginButton.isEnabled = !flag
        loginButton.alpha = !flag ? 1.0 : 0.7
    }
    
    func configureLoginButton() {
        emailTextField.text = ""
        passwordTextField.text = ""
        loginButton.isEnabled = true
        setUIButton(false)
    }
    
    func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }
    
    func performRefereshIndicator(_ flag:Bool) {
        
        if flag {
            activityIndicator.stopAnimating()
        }else {
            activityIndicator.startAnimating()
        }
        
        
    }
}


