//
//  UserCell.swift
//  PruebaCeiba
//
//  Created by Santiago Rodriguez on 10/06/22.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    
    var delegate:UserCellDelegate?
    var index:Int?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func goToPostsAction(_ sender: Any) {
        self.delegate?.goToPosts(index: self.index!)
    }
    
    
}

protocol UserCellDelegate{
    func goToPosts(index:Int)
}
