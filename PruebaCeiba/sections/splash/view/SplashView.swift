//
//  SplashView.swift
//  PruebaCeiba
//
//  Created by Santiago Rodriguez on 10/06/22.
//

import UIKit

class SplashView: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel = SplashViewModel()
    private var router = SplashRouter()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.bind(view: self, router: self.router)
        self.initViews()
    }
    
    private func initViews(){
        self.configActivityIndicator()
    }
    
    private func configActivityIndicator(){
        self.activityIndicator.configDefault()
        self.activityIndicator.color = .darkGray
    }

}
