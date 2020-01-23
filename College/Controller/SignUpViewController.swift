//
//  SignUpViewController.swift
//  College
//
//  Created by João Victor on 03/01/20.
//  Copyright © 2020 João Victor. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignUpViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cpfTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utils.cornerButton(signUpButton)
        
        nameTextField.text = "Alguem"
        cpfTextField.text = "999.999.999-99"
        emailTextField.text = "alguem@mail.com"
        phoneTextField.text = "(61)9999-99999"
        passwordTextField.text = "123123"
        

    }
    
    func signUp() {
        let name = nameTextField.text
        let cpf = cpfTextField.text
        let email = emailTextField.text
        let phone = phoneTextField.text
        let pwd = passwordTextField.text
        
        let parameters = ["usuario": ["email": email,
                                      "senha": pwd,
                                      "cpf": cpf,
                                      "nome": name,
                                      "telefone": phone]]
        print(JSON(parameters))
        
        Routes.studentSignUp(URL: "\(Values.host)/aluno/register",
            parameters: parameters as Parameters,
            onSuccess: { response in
                let json = JSON(response)
                
                if let message = json["message"].string, !(message.isEmpty),
                    let codeStudent = json["Matricula"].string, !(codeStudent.isEmpty) {
                    
                    let alert = UIAlertController(title: message, message: "Sua matrícula é \(codeStudent)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.performSegue(withIdentifier: "signUp_to_login", sender: nil)
                    }
                }
            },
            onFailure: { failure in
                Utils.showToastMessage(message: "O servidor está bravo com você ou apenas dormindo!", destination: self.self)
            })
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        let validate = validateFields()
        
        if validate == true {
            signUp()
        } else {
            print("Data is not valid")
        }
    }
    
    func validateFields() -> Bool {
        var filled = true
        
        if let name = nameTextField.text, !name.isEmpty,
            let cpf = cpfTextField.text, !cpf.isEmpty,
            let phone = phoneTextField.text, !phone.isEmpty,
            let email = emailTextField.text, !email.isEmpty {
            
            filled = true
        
        } else {
            
            filled = false
            
            let alert = UIAlertController(title: "Dados incorretos", message: "Confira se os dados estão corretos!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        return filled
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
    
        if let cell = cell {
            cell.selectionStyle = .none
        }
    }
    
    
}
