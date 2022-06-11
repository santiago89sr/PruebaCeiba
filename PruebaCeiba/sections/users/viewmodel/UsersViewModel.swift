//
//  UsersViewModel.swift
//  PruebaCeiba
//
//  Created by Santiago Rodriguez on 10/06/22.
//

import Foundation
import RxSwift

class UsersViewModel{
    
    private weak var view: UsersView?
    private var router: UsersRouter?
    private var disposeBag = DisposeBag()
    private var apiRest = APIRest()
    
    private let db = DBHelper()
    
    var users:[User] = []
    
    var usersCorrect: ((_ response:[User]) -> ())?
    var usersError: ((_ error:String) -> ())?
    
    func bind(view: UsersView, router: UsersRouter){
        self.view = view
        self.router = router
        //Se enlaza el router con la vista
        self.router?.setSourceView(view)
        self.validateGetUsers()
    }
    
    func navigateToPostsRouter(userId: String){
        self.router?.navigateToPostsRouter(userId: userId)
    }
    
    private func validateGetUsers(){
        self.users = db.readUsers()
        if users.count == 0 {
            getUsers()
        }else{
            self.view?.setDataFromDB(users: self.users)
        }
    }
    
    private func getUsers(){
       self.view?.present(self.view!.loadingView, animated: true, completion: {
            return self.apiRest.getUsers()
                .observe(on: MainScheduler.instance)
                .subscribe { response in
                    self.users = response
                } onError: { error in
                    self.usersError!(error.localizedDescription)
                } onCompleted: {
                    self.saveUsersDB()
                }.disposed(by: self.disposeBag)
        })
    }
    
    private func saveUsersDB(){
        _ = self.users.map( {db.insertUser(user: $0)} )
        self.usersCorrect!(self.users)
    }

}
