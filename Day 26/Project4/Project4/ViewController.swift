//
//  ViewController.swift
//  Project4
//
//  Created by Martin Kabát on 05.04.2022.
//

import UIKit
import WebKit

class ViewController: UITableViewController {
    var webview: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]
    
    override func loadView() {
        //webview = WKWebView()
        //webview.navigationDelegate = self
        //view = webview
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        // Two buttons on the left
        let back: UIBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(pageBack))
        
        let forward: UIBarButtonItem = UIBarButtonItem(title: "Forward", style: .plain, target: self, action: #selector(pageForward))
        
        navigationItem.leftBarButtonItems = [back, forward]
        
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webview, action: #selector(webview.reload))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
//        webview.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
//
//        let url = URL(string: "https://" + websites[0])!
//        webview.load(URLRequest(url: url))
//        webview.allowsBackForwardNavigationGestures = true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        
        return cell
    }
                                                            
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
       
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem // iPad handling (where to anchor the action sheet)
        present(ac, animated: true)
    }
    
    @objc func pageBack() {
        webview.goBack()
    }
    
    @objc func pageForward() {
        webview.goForward()
    }
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webview.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webview.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let estimatedProgress = webview.estimatedProgress
            progressView.progress = Float(estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url

        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
            
            // Website other than the one from the list is not allowed
            let ac = UIAlertController(title: nil, message: "This URL is not allowed", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    
            present(ac, animated: true)
            
            decisionHandler(.cancel)
            return
        }

        decisionHandler(.cancel)
    }
}
