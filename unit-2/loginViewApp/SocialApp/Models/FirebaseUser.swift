//
//  FirebaseUser.swift
//  SocialApp
//
//  Created by Игорь Ершов on 16.12.2020.
//

import Foundation
import FirebaseDatabase

class FirebaseUser {
    let userId: Int
    let date: String
    let ref: DatabaseReference?
    
    init(userId: Int){
        self.userId = userId
        self.date = Date().description
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
            // 3
            guard
                let value = snapshot.value as? [String: Any],
                let userId = value["userId"] as? Int,
                let date = value["date"] as? String else {
                    return nil
            }
            
            self.ref = snapshot.ref
            self.userId = userId
            self.date = date
        }

    func toAnyObject() -> [String: Any] {
            // 4
            return [
                "userId": userId,
                "date": date
            ]
        }

}
