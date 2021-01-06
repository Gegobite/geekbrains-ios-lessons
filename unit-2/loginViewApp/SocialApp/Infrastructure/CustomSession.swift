//
//  CustomSession.swift
//  SocialApp
//
//  Created by Игорь Ершов on 23.11.2020.
//

import Foundation
import Alamofire

extension Session {
    static let custom: Session = {
        let configuration = URLSessionConfiguration.default
        let sessionManager = Session(configuration: configuration)
        return sessionManager
    }()
}
