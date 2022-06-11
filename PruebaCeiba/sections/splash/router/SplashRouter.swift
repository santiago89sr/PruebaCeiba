//
//  SplashRouter.swift
//  PruebaCeiba
//
//  Created by Santiago Rodriguez on 10/06/22.
//

import Foundation
import UIKit

class SplashRouter {
    
    private var sourceView: UIViewController?
    
    var viewController: UIViewController{
        return createViewController()
    }
    
    private func createViewController() -> UIViewController{
        let view = SplashView(nibName: "SplashView", bundle: Bundle.main)
        return view
    }
    
    func setSourceView( _ sourceView: UIViewController? ) {
        guard let view = sourceView else {fatalError("Error desconocido")}
        self.sourceView = view
    }
    
    func navigateToUsersRouter(){
        let newView = UsersRouter().viewController
        sourceView?.navigationController?.pushViewController(newView, animated: true)
    }
}
