//
//  ErrorService.swift
//  PruebaCeiba
//
//  Created by Santiago Rodriguez on 10/06/22.
//

import Foundation
import Alamofire

class ErrorService{
    
    func createError(response:AFDataResponse<Data?>) -> Error{
        let message = "Error Servicio"
        let userInfo =
            [
                NSLocalizedDescriptionKey :  NSLocalizedString("Exception", value: message, comment: "")
            ]
        let err = NSError(domain: "", code: response.response!.statusCode, userInfo: userInfo)
        return err
    }
    
}
