//
//  APIRest.swift
//  PruebaCeiba
//
//  Created by Santiago Rodriguez on 10/06/22.
//

import Foundation
import RxSwift
import Alamofire

class APIRest {
    
    private let successful = 200

    func getUsers() -> Observable<[User]> {
        
        let url = Constants.URL.main + Constants.ENDPOINTS.users
        
        let request = AF.request(url, method: .get)
        
        return Observable.create { observer -> Disposable in
            request.response { response in
                    switch response.result {
                    case .success:
                        print("✅ statusCode: \(String(describing: response.response?.statusCode)) service: \(String(describing: response.request?.urlRequest)) response: \(response.description)")
                        guard let data = response.data else { return }
                        guard let statusCode = response.response?.statusCode else { return }
                        do {
                            if statusCode == self.successful{
                                let dataObj = try JSONDecoder().decode([User].self, from: data)
                                observer.onNext(dataObj)
                            }else{
                                let err = ErrorService().createError(response: response)
                                observer.onError(err)
                            }
                        }catch {
                            observer.onError(error)
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
                    observer.onCompleted()
            }
            
         
                return Disposables.create()
            }
        
    }
    
    func getPosts(userId:String) -> Observable<[Post]> {
        
        let url = Constants.URL.main + Constants.ENDPOINTS.posts + "?userId=\(userId)"
        
        let request = AF.request(url, method: .get)
        
        return Observable.create { observer -> Disposable in
            request.response { response in
                    switch response.result {
                    case .success:
                        print("✅ statusCode: \(String(describing: response.response?.statusCode)) service: \(String(describing: response.request?.urlRequest)) response: \(response.description)")
                        guard let data = response.data else { return }
                        guard let statusCode = response.response?.statusCode else { return }
                        do {
                            if statusCode == self.successful{
                                let dataObj = try JSONDecoder().decode([Post].self, from: data)
                                observer.onNext(dataObj)
                            }else{
                                let err = ErrorService().createError(response: response)
                                observer.onError(err)
                            }
                        }catch {
                            observer.onError(error)
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
                    observer.onCompleted()
            }
            
         
                return Disposables.create()
            }
        
    }
    
}
