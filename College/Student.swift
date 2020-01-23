import Foundation

class Student {
    //colocar nil para as variaveis para poder validar
    var email: String = ""
    var cpf: String = ""
    var cod_student: String = ""
    var name:String = ""
    var phone: String = ""
    var token: String = ""
    
    init(email: String, cpf: String, cod_student: String, name: String, phone: String) {
        self.email = email
        self.cpf = cpf
        self.cod_student = cod_student
        self.name = name
        self.phone = phone
    }
    
    init() {
        
    }
}
