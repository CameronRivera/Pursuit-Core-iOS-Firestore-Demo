//
//  PostCell.swift
//  FirestoreDemo
//
//  Created by Cameron Rivera on 3/8/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import UIKit
import FirebaseAuth

class PostCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userIDLabel: UILabel!
    
    public func configureCell(_ post: Post, _ user: User){
        titleLabel.text = post.title
        dateLabel.text = DateConverter.makeMyDateAString(Date(timeIntervalSince1970: Double(post.date.seconds)))
        userEmailLabel.text = "User Email: \(user.email ?? "")"
        userIDLabel.text = "User Id: \(user.uid)"
    }
}
