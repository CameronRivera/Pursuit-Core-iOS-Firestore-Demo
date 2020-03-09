//
//  AddNewCommentController.swift
//  FirestoreDemo
//
//  Created by Cameron Rivera on 3/8/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import UIKit

protocol AddNewCommentControllerProtocol: AnyObject{
    func postNewCommentButtonPressed(_ addNewCommentController: AddNewCommentController, _ newComment: Comment)
}

class AddNewCommentController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    weak var delegate: AddNewCommentControllerProtocol?
    
    override func viewWillLayoutSubviews() {
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func postCommentButtonPressed(_ sender: UIButton){
        guard let textFieldText = textField.text, !textFieldText.isEmpty,
            let textViewText = textView.text, !textViewText.isEmpty else {
                showAlert("Missing Fields", "One or more fields is missing.")
                return
        }
        
        let newComment = Comment(textFieldText,textViewText)
        delegate?.postNewCommentButtonPressed(self, newComment)
        dismiss(animated: true)
    }
}

extension AddNewCommentController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
