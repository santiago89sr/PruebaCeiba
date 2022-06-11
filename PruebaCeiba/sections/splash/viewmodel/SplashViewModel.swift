//
//  SplashViewModel.swift
//  PruebaCeiba
//
//  Created by Santiago Rodriguez on 10/06/22.
//

import Foundation

class SplashViewModel{
    
    private weak var view: SplashView?
    private var router: SplashRouter?
    
    func bind(view: SplashView, router: SplashRouter){
        self.view = view
        self.router = router
        //Se enlaza el router con la vista
        self.router?.setSourceView(view)
        self.navigateToUsersRouter()
    
    }
    
    func navigateToUsersRouter(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.router?.navigateToUsersRouter()
        }
    }
    
    
}
