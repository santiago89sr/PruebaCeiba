//
//  UsersRouter.swift
//  PruebaCeiba
//
//  Created by Santiago Rodriguez on 10/06/22.
//

import Foundation
import UIKit

class UsersRouter {
    
    private var sourceView: UIViewController?
    
    var viewController: UIViewController{
        return createViewController()
    }
    
    private func createViewController() -> UIViewController{
        let view = UsersView(nibName: "UsersView", bundle: Bundle.main)
        return view
    }
    
    func setSourceView( _ sourceView: UIViewController? ) {
        guard let view = sourceView else {fatalError("Error desconocido")}
        self.sourceView = view
    }
    
    func navigateToPostsRouter(userId: String){
        let view = PostsRouter(userId: userId).viewController
        sourceView?.navigationController?.pushViewController(view, animated: true)
    }
    
}
