//
//  DataContext.swift
//  SocialApp
//
//  Created by Игорь Ершов on 19.10.2020.
//

import Foundation

class DataContext {
    
    static var instance: DataContext = DataContext()
    
    var users: [User] = []
    var friends: [Friend] = []
    var groups: [Group] = []
    var currentUser: User?
    
    init() {
        loadGroups()
        loadFriends()
        createTestUser()
    }
    
    func getUserByLogin(login: String) -> User?{
        return users.filter({$0.login == login}).first
    }
    
    func setCurrentUser(user: User){
        self.currentUser = user
    }
    
    private func loadFriends(){
        friends = [
            Friend(name: "Ivan Ivanov",
                 mainImage: "AvatarIvanov", images: ["Ivanov1", "Ivanov2"]),
            
            Friend(name: "Pupka Pupkin",
                 mainImage: "AvatarPupkin", images: ["Pupkin1", "Pupkin2"])
        ]
    }
    
    private func loadGroups(){
        groups = [
            Group(name: "First group 1", mainImage: "Group1"),
            Group(name: "Second group 2", mainImage: "Group2"),
            Group(name: "Second group 3", mainImage: "Group3"),
            Group(name: "My group 4", mainImage: "Group4")
        ]
    }
    
    private func createTestUser(){
        users.append(
            User(login: "admin", password: "admin", name: "Admin",
                 mainImage: "Admin", images: nil,
                 friends: friends,
                 groups: groups.filter({!$0.name.contains("4")}))
        )
    }
}
