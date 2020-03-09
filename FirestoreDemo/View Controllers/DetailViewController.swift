//
//  DetailViewController.swift
//  FirestoreDemo
//
//  Created by Cameron Rivera on 3/8/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import UIKit
import FirebaseFirestore

class DetailViewController: UIViewController {

    @IBOutlet weak var initialCommentView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private var currentPost: Post{
        didSet{
            DispatchQueue.main.async{
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        collectionView.layer.borderColor = UIColor.black.cgColor
        collectionView.layer.borderWidth = 1.0
        initialCommentView.layer.borderColor = UIColor.black.cgColor
        initialCommentView.layer.borderWidth = 1.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    init?(_ coder: NSCoder, _ post: Post){
        currentPost = post
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CommentCell", bundle: nil), forCellWithReuseIdentifier: "commentCell")
        initialCommentView.text = currentPost.body
        titleLabel.text = currentPost.title
    }
    
    @IBAction func addNewPostButtonPressed(_ sender: UIButton){
        guard let addNewCommentVC = storyboard?.instantiateViewController(identifier: "AddNewCommentController") as? AddNewCommentController else {
            fatalError("Could not create instance of AddNewCommentController.")
        }
        addNewCommentVC.delegate = self
        present(addNewCommentVC, animated: true)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width * 0.9, height: collectionView.bounds.size.height * 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension DetailViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentPost.comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let xCell = collectionView.dequeueReusableCell(withReuseIdentifier: "commentCell", for: indexPath) as? CommentCell else {
            fatalError("Could not dequeue cell as a comment cell.")
        }
        xCell.configureCell(currentPost.comments[indexPath.row])
        xCell.backgroundColor = .systemGray4
        return xCell
    }
}

extension DetailViewController: AddNewCommentControllerProtocol{
    func postNewCommentButtonPressed(_ addNewCommentController: AddNewCommentController, _ newComment: Comment) {
        
        currentPost.comments.append(newComment)
        
        FirestoreService.manager.create(currentPost) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.showAlert("Post Update Error", "\(error.localizedDescription)")
            case .success:
                self?.showAlert("Success", "Post was successfully updated.")
            }
        }
    }
}
