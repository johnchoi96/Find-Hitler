//
//  AboutViewController.swift
//  FindHitler
//
//  Created by John Choi on 4/15/20.
//  Copyright © 2020 John Choi. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var backBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "About"
        let address = URL(string: "https://johnchoi96.github.io")
        let url = URLRequest(url: address!)
        webview?.load(url)
        webview.allowsBackForwardNavigationGestures = true
        webview.navigationDelegate = self
        
        backBtn.isEnabled = false
    }
    
    /// WebKit Delegate function.
    /// Called everytime the player clicks on the link.
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("called")
        backBtn.isEnabled = webview.canGoBack
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backBtnPressed(_ sender: Any) {
        webview.goBack()
    }
    
}
