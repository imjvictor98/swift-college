import Foundation
import Alamofire
import SwiftyJSON

class Routes {
    /*
     @param1: URL or localhost
     @param2: parameters of request's body
     @param3: callback for success
     @param4: callback for an error
     */
    static func studentLogin(URL: String,
                             parameters body: Parameters ,
                             onSuccess sucess: @escaping (_ JSON: Any) -> (),
                             onError error: @escaping (_ errorMessage: String) -> ()) {
        
        AF.request(URL,
                   method: .post,
                   parameters: body,
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
                switch response.result {
                case .success(let data):
                    let studentInfo = JSON(data)
                    sucess(studentInfo)
                case .failure(let serverError):
                    if serverError.errorDescription != nil{
                        error("Seus dados podem estar incorretos 😢")
                    }
                }
        }
    }
    
    static func studentSignUp(URL: String,
                              parameters body: Parameters,
                              onSuccess success: @escaping (_ JSON: Any) -> (),
                              onFailure failure: @escaping (_ errorMessage: String) -> ()) {
        
        AF.request(URL,
                   method: .post,
                   parameters: body,
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
                switch response.result {
                case .success(let data):
                    success(JSON(data))
                case .failure(let serverError):
                    if serverError.errorDescription != nil {
                        failure("Usuário não pode ser criado!")
                    }
                    
                }
        }
    }
}


