//
//  PostsViewModel.swift
//  PruebaCeiba
//
//  Created by Santiago Rodriguez on 11/06/22.
//

import Foundation
import RxSwift

class PostsViewModel{
    
    private weak var view: PostsView?
    private var router: PostsRouter?
    private var disposeBag = DisposeBag()
    private var apiRest = APIRest()
    
    var posts:[Post] = []
    
    var postsCorrect: ((_ response:[Post]) -> ())?
    var postsError: ((_ error:String) -> ())?
    
    func bind(view: PostsView, router: PostsRouter){
        self.view = view
        self.router = router
        //Se enlaza el router con la vista
        self.router?.setSourceView(view)
    }
    
    func navigateToBack(){
        self.router?.navigateToBack()
    }
    
    func getPosts(userId: String){
       self.view?.present(self.view!.loadingView, animated: true, completion: {
            return self.apiRest.getPosts(userId: userId)
                .observe(on: MainScheduler.instance)
                .subscribe { response in
                    self.posts = response
                } onError: { error in
                    self.postsError!(error.localizedDescription)
                } onCompleted: {
                    self.postsCorrect!(self.posts)
                }.disposed(by: self.disposeBag)
        })
    }

}

