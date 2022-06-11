//
//  UsersView.swift
//  PruebaCeiba
//
//  Created by Santiago Rodriguez on 10/06/22.
//

import UIKit

class UsersView: UIViewController {
    
    @IBOutlet weak var usersTableView: UITableView!
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var emptyLbl: UILabel!

    private var viewModel = UsersViewModel()
    private var router = UsersRouter()
    
    private let cellIdentifier = "UserCell"
    private var users = [User]()
    private var filterUsers = [User]()
    
    let loadingView = LoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.bind(view: self, router: self.router)
        self.initViews()
        self.initViewModels()
    }
    
    private func initViews(){
        self.loadingView.modalPresentationStyle = .overCurrentContext
        
        self.configTableView(tableView: self.usersTableView)
        
        self.searchField.placeholder = "Search user"
        self.searchField.returnKeyType = .search
        self.searchField.delegate = self
        self.searchField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func setDataFromDB(users:[User]){
        self.users = users
        self.reloadTableView(tableView: self.usersTableView)
    }
    
    private func initViewModels(){
        viewModel.usersCorrect = { response in
            self.users = response
            self.loadingView.dismiss(animated: true, completion: {
                self.reloadTableView(tableView: self.usersTableView)
            })
        }
        
        viewModel.usersError = { error in
            self.loadingView.dismiss(animated: true, completion: {
                print(error)
            })
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text{
            self.filterUsers = self.users.filter { user in
                return user.name.lowercased().contains(text.lowercased())
              }
        }else{
            self.filterUsers.removeAll()
        }
        self.reloadTableView(tableView: self.usersTableView)
    }
    
    private func reloadTableView(tableView:UITableView) {
        DispatchQueue.main.async {
            tableView.reloadData()
        }
    }
    
    private func configTableView(tableView:UITableView){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: self.cellIdentifier, bundle: nil), forCellReuseIdentifier: self.cellIdentifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.tableFooterView?.backgroundColor = UIColor.clear
    }

}

extension UsersView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let text = self.searchField.text{
            
            if text.isEmpty{
                return self.users.count
            }else{
                if self.filterUsers.count == 0 {
                    self.emptyLbl.isHidden = false
                }else{
                    self.emptyLbl.isHidden = true
                }
                return self.filterUsers.count
            }
        }
        
        return self.users.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! UserCell
        
        var user:User?
        
        if self.filterUsers.count == 0 {
            user = self.users[indexPath.row]
        }else{
            user = self.filterUsers[indexPath.row]
        }
        cell.index = indexPath.row
        cell.delegate = self
        cell.name.text = user?.name ?? ""
        cell.phone.text = user?.phone ?? ""
        cell.email.text = user?.email ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230.0
    }
    
}

extension UsersView: UserCellDelegate{
    func goToPosts(index: Int) {
        var user:User?
        
        if self.filterUsers.count == 0 {
            user = self.users[index]
        }else{
            user = self.filterUsers[index]
        }
        viewModel.navigateToPostsRouter(userId: "\(user!.id)")
    }
}

extension UsersView: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
    }
}
