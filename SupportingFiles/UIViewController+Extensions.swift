//
//  UIViewController+Extensions.swift
//  FirestoreDemo
//
//  Created by Cameron Rivera on 3/8/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import UIKit

extension UIViewController{
    func showAlert(_ title: String, _ message: String, completion: ((UIAlertAction) -> ())? = nil){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: completion)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

