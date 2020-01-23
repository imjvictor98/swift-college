import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    //MARK:- Variáveis
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    var student:Student = Student()
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    //MARK:- Funções de ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.center = view.center
        Utils.cornerButton(signInButton)
        
        codeTextField.text = "A2300"
        pwdTextField.text = "123123"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
       super.viewDidDisappear(animated)
       signInButton.isUserInteractionEnabled = true
    }
   
    //MARK:- Métodos de transição
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login_to_dashboard" {
            let homeVC: HomeTableViewController = segue.destination as! HomeTableViewController
            homeVC.student = student
        }
    }
    
    //MARK:- Métodos de botões
    @IBAction func loginTapped(sender: UIButton) {
        
        let validate = validateFields(codeOfStudent: codeTextField.text!, passworfOfStudent: pwdTextField.text!)
        
        
        if validate == false {
            print("Fields not valid!")
        } else {
        
            self.activityIndicator.startAnimating()

            view.addSubview(activityIndicator)
            
            self.login()
            
            signInButton.isUserInteractionEnabled = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if self.student.name.count > 3 {
                    self.performSegue(withIdentifier: "login_to_dashboard", sender: nil)
                }
                self.activityIndicator.stopAnimating()
            }
        }
        self.signInButton.isUserInteractionEnabled = true
    }
    
   

    //MARK:- Helpers para a tela de login
    func login() {
        let email = codeTextField.text
        let password = pwdTextField.text
        let parameters = ["codigo": email, "senha": password]
        
        Routes.studentLogin(URL: "\(Values.host)/aluno/login",
            parameters: parameters as Parameters,
            onSuccess: { result in
                let json = JSON(result)
                
                self.student = self.jsonToClass(json: json) ?? Student()
                return
            }, onError: { error in
                Utils.showToastMessage(message: error, destination: self.self)
                return
            })
    }
    
    func jsonToClass(json: JSON)-> Student? {
        let data = json["user"]
        
        let code_student = json["cod_aluno"].string
        let user_phone = data["telefone"].string
        let user_email = data["email"].string
        let user_cpf = data["cpf"].string
        let user_name = data["nome"].string
        
        guard let email = user_email, !(email.isEmpty) else {return nil}
        guard let name = user_name, !(name.isEmpty) else {return nil}
        guard let phone = user_phone, !(phone.isEmpty) else {return nil}
        guard let cpf = user_cpf, !(cpf.isEmpty) else {return nil}
        guard let code = code_student, !(code.isEmpty) else {return nil}
        
        let newStudent = Student(email: email,
                                 cpf: cpf,
                                 cod_student: code,
                                 name: name,
                                 phone: phone)
        
        return newStudent
        
    }
    
    func validateFields(codeOfStudent code: String, passworfOfStudent password: String) -> Bool {
        let code = codeTextField.text
        let password = pwdTextField.text
        var filled = true
        
        if let text = code, !text.isEmpty,
            let pwd = password, !pwd.isEmpty {
               filled = true
        } else {
            Utils.showToastMessage(message: "Dados incorretos!", destination: self)
            filled = false
        }
        return filled
    }
}

