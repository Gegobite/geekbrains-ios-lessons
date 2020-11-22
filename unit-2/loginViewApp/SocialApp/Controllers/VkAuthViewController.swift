//
//  VkAuthViewController.swift
//  SocialApp
//
//  Created by Игорь Ершов on 20.11.2020.
//

import UIKit
import WebKit

class VkAuthViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView! {
        didSet{
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: ConnectionSettings.current.clientId),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: ConnectionSettings.current.clientScope),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: ConnectionSettings.current.apiVersion)
        ]
                
        let request = URLRequest(url: urlComponents.url!)
                
        webView.load(request)
        // Do any additional setup after loading the view.
    }

}

extension VkAuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        let token = params["access_token"]
        let userId = params["user_id"]
        
        AppSessionManager.currentSession.token = token!
        AppSessionManager.currentSession.userId = Int(userId!) ?? -1
        
        
        decisionHandler(.cancel)
        
        let contoller = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: "TabViewController") as! TabViewController
        contoller.modalPresentationStyle = .fullScreen
        present(contoller, animated: true, completion: nil)
    }
}
