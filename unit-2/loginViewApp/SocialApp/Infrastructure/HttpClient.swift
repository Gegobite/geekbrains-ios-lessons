//
//  WebClient.swift
//  SocialApp
//
//  Created by Игорь Ершов on 20.11.2020.
//
import Alamofire

class HttpClient {
    var baseUrl: String!
    
    func setBaseUrl(as baseUrl: String){
        self.baseUrl = baseUrl
    }
    
    func postAsJson<TValue: Encodable>(path: String, value: TValue) -> String {
        let urlString = baseUrl + path
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(value)
        
        let url = URL(string: urlString)!

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        var jsonResponse : String = ""
        
        AF.request(request).responseJSON {
            (response) in
            jsonResponse = String(describing: response.value)
        }
        
        return jsonResponse
    }
    
    func postFromJson(path: String, params: Parameters, completion: @escaping (Data) -> Void) {
        return sendCommonJsonRequest(path: path, method: .post, params: params, completion: completion)
    }
    
    func getFromJson(path: String, params: Parameters, completion: @escaping (Data) -> Void) {
        sendCommonJsonRequest(path: path, method: .get, params: params, completion: completion)
    }
    
    func getFromJson<TEntity: Decodable>(_ dump: TEntity.Type, path: String, params: Parameters, completion: @escaping (TEntity?) -> Void) {
        sendCommonJsonRequest(path: path, method: .get, params: params) { data in
            do{
                let str = String(decoding: data, as: UTF8.self)
                let entity = try JSONDecoder().decode(TEntity.self, from: data)
                completion(entity)
            }
            catch{
                print(error)
                completion(nil)
            }
        }
    }
    
    private func sendCommonJsonRequest(path: String, method: HTTPMethod, params: Parameters, completion: @escaping (Data) -> Void) {
        let urlString = baseUrl + path
    
        Session.custom.request(urlString, method: method, parameters: params).responseData {
            (response) in
            guard let data = response.value else {return}
            completion(data)
        }
    }
}
