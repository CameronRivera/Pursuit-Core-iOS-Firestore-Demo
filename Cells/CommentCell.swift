//
//  CommentCell.swift
//  FirestoreDemo
//
//  Created by Cameron Rivera on 3/8/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import UIKit

class CommentCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyView: UITextView!
    
    public func configureCell(_ comment: Comment){
        titleLabel.text = comment.title
        bodyView.text = comment.body
    }
}
