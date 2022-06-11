//
//  PostsRouter.swift
//  PruebaCeiba
//
//  Created by Santiago Rodriguez on 11/06/22.
//

import Foundation
import UIKit

class PostsRouter {
    
    private var userId:String?
    private var sourceView: UIViewController?
    
    init(userId:String? = ""){
        self.userId = userId
    }
    
    var viewController: UIViewController{
        return createViewController()
    }
    
    private func createViewController() -> UIViewController{
        let view = PostsView(nibName: "PostsView", bundle: Bundle.main)
        view.userId = self.userId!
        return view
    }
    
    func setSourceView( _ sourceView: UIViewController? ) {
        guard let view = sourceView else {fatalError("Error desconocido")}
        self.sourceView = view
    }
    
    func navigateToBack(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
}
