//
//  UIActivityIndicatorViewExtension.swift
//  PruebaCeiba
//
//  Created by Santiago Rodriguez on 10/06/22.
//

import UIKit

extension UIActivityIndicatorView{
    
    func configDefault(){
        self.color = .darkGray
        self.startAnimating()
        self.hidesWhenStopped = true
        self.style = .medium
    }
    
}
