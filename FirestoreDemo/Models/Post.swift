import Foundation
import FirebaseFirestore

struct Comment: Codable {
    let title: String
    let body: String
    
    init(_ title: String, _ body: String){
        self.title = title
        self.body = body
    }
    
    init?(from dict: [String: Any], andUUID uuid: UUID) {
        guard let title = dict["title"] as? String,
            let body = dict["body"] as? String
            else {
                return nil
        }
        self.title = title
        self.body = body
    }
    
    var dict: [String : Any]{
        return [
            "title" : title,
            "body" : body
        ]
    }
}

struct Post {
    let title: String
    let body: String
    let uuid: UUID
    let userUID: String
    let date: Timestamp
    var comments: [Comment]
    
    init(title: String, body: String, userUID: String, date: Timestamp, comments: [Comment]) {
        self.title = title
        self.body = body
        self.uuid = UUID()
        self.userUID = userUID
        self.date = date
        self.comments = comments
    }
    
    init?(from dict: [String: Any], andUUID uuid: UUID) {
        guard let title = dict["title"] as? String,
            let body = dict["body"] as? String,
            let userUID = dict["userUID"] as? String,
            let date = dict["date"] as? Timestamp else {
                return nil
        }
        self.title = title
        self.body = body
        self.userUID = userUID
        self.uuid = uuid
        self.date = date
    
        var commentArray: [Comment] = []
        if let entry = dict["comments"] as? [[String: Any]] {
            for entries in entry{
                if let title = entries["title"] as? String,
                    let body = entries["body"] as? String {
                    commentArray.append(Comment(title,body))
                }
            }
        }
        
        self.comments = commentArray
    }
    
    var uuidStr: String {
        return uuid.uuidString
    }
    
    var fieldsDict: [String: Any] {
        var newComment: [[String:Any]] = []
        for comment in comments{
            newComment.append(comment.dict)
        }
        return [
            "title": title,
            "body": body,
            "userUID": userUID,
            "date": date,
            "comments": newComment
        ]
    }
}
