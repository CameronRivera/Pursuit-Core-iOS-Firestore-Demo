import UIKit
import FirebaseFirestore
import FirebaseAuth

class PostsViewController: UIViewController {
    
    // MARK: -IBOutlets
    
    @IBOutlet var postsTableView: UITableView!
    
    // MARK: -Internal Properties
    
    var posts = [Post]() {
        didSet {
            postsTableView.reloadData()
        }
    }
    
    // MARK: -Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "postCell")
        loadPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPosts()
    }
    
    // MARK: - Private Methods
    
    private func loadPosts() {
        FirestoreService.manager.getPosts { [weak self] (result) in
            self?.handleFetchPostsResponse(withResult: result)
        }
    }
    
    private func handleFetchPostsResponse(withResult result: Result<[Post], Error>) {
        switch result {
        case let .success(posts):
            self.posts = posts.sorted{$0.date.seconds < $1.date.seconds}
        case let .failure(error):
            print("An error occurred fetching the posts: \(error)")
        }
    }
    
}

// MARK: -Table View Delegate

extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedVC = storyboard?.instantiateViewController(identifier: "DetailViewController", creator: { coder in
            return DetailViewController(coder, self.posts[indexPath.row])
        })
        
        if let vc = detailedVC {
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true, completion: nil)
        }
    }
}

// MARK: -Table View Data Source

extension PostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let xCell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostCell, let user = Auth.auth().currentUser else {
            fatalError("Could not dequeue cell as a PostCell")
        }
        let post = posts[indexPath.row]
        xCell.configureCell(post, user)
        return xCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
}
