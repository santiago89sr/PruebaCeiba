//
//  LoadingView.swift
//  PruebaCeiba
//
//  Created by Santiago Rodriguez on 10/06/22.
//

import UIKit

class LoadingView: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.configDefault()
        self.activityIndicator.color = .white
        
    }


}
