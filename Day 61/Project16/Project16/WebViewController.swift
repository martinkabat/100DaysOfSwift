//
//  WebViewController.swift
//  Project16
//
//  Created by Martin Kabát on 15.11.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController, UIWebViewDelegate, WKNavigationDelegate {
    @IBOutlet var webView: WKWebView!

    var selectedCity: String?
    var baseWikiURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedCity
        
        webView = WKWebView()
        baseWikiURL = "https://en.wikipedia.org/wiki/"
        let wikiURL = URL(string:"\(String(describing: baseWikiURL!))\(String(describing: selectedCity!))")
        let request = URLRequest(url: wikiURL!)
        webView.load(request)
        
        view.addSubview(webView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        webView.frame = view.bounds
    }
}
