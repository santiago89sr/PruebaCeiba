//
//  PostsView.swift
//  PruebaCeiba
//
//  Created by Santiago Rodriguez on 11/06/22.
//

import UIKit

class PostsView: UIViewController {

    @IBOutlet weak var postsTableView: UITableView!

    private var viewModel = PostsViewModel()
    private var router = PostsRouter()
    private var posts = [Post]()
    
    let loadingView = LoadingView()
    
    var userId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.bind(view: self, router: self.router)
        self.initViews()
        self.initViewModels()
    }
    
    private func initViews(){
        self.loadingView.modalPresentationStyle = .overCurrentContext
        
        self.configTableView(tableView: self.postsTableView)
        
        viewModel.getPosts(userId: self.userId)
    }
    
    private func initViewModels(){
        viewModel.postsCorrect = { response in
            self.posts = response
            self.loadingView.dismiss(animated: true, completion: {
                self.reloadTableView(tableView: self.postsTableView)
            })
        }
        
        viewModel.postsError = { error in
            self.loadingView.dismiss(animated: true, completion: {
                print(error)
            })
        }
    }
    
    private func reloadTableView(tableView:UITableView) {
        DispatchQueue.main.async {
            tableView.reloadData()
        }
    }
    
    private func configTableView(tableView:UITableView){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.tableFooterView?.backgroundColor = UIColor.clear
    }

    @IBAction func backAction(_ sender: Any) {
        viewModel.navigateToBack()
    }
    
}

extension PostsView: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        let post = self.posts[indexPath.row]
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "\(post.title)"
        
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = "\(post.body)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
}
