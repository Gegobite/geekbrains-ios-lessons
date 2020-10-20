//
//  DataContext.swift
//  SocialApp
//
//  Created by Игорь Ершов on 19.10.2020.
//

import UIKit

class DataContext {
    
    static var instance: DataContext = DataContext()
    
    var users: [User] = []
    var friends: [Friend] = []
    var groups: [Group] = []
    var currentUser: User?
    var news: [News] = []
    
    init() {
        loadGroups()
        loadFriends()
        createTestUser()
        loadNews()
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
                 mainImage: "AvatarIvanov", images: ["Ivanov1", "Ivanov2", "ImageBackground"]),
            
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
    
    private func loadNews(){
        news = [
            News(friend: friends[0], createDate: Date(),
                text: "Lorem ipsum", image: nil),
            News(friend: friends[1], createDate: Date(),
                text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", image: UIImage(named: "Group1"))
        ]
    }
}
