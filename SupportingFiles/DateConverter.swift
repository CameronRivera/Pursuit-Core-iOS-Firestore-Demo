//
//  DateConverter.swift
//  FirestoreDemo
//
//  Created by Cameron Rivera on 3/8/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import Foundation

struct DateConverter{
    static func makeMyDateAString(_ date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d, YYYY h:mm a"
        return dateFormatter.string(from: date)
    }
}
