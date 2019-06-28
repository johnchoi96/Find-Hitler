//
//  ViewController.swift
//  FindHitler
//
//  Created by John Choi on 6/28/19.
//  Copyright © 2019 John Choi. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webkit: WKWebView!
    @IBOutlet weak var scoreLbl: UILabel!
    
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let urlAddress = URL(string: "https://en.wikipedia.org/wiki/Special:Random") // start point
        let url = URLRequest(url: urlAddress!)
        webkit?.load(url)
        webkit.navigationDelegate = self
        
        scoreLbl.text = String(format: "Score: %d", score)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print(webView.url!.absoluteString)
        if webView.url!.absoluteString == "https://en.wikipedia.org/wiki/Adolf_Hitler" {
            let alert = UIAlertController(title: "Congratulations!", message: "You found the Fuhrer :/", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            webkit.isUserInteractionEnabled = true
            return
        }
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            print("link")
            score += 1
            
            scoreLbl.text = String(format: "Score: %d", score)
            decisionHandler(WKNavigationActionPolicy.allow)
            
            print("After" + webView.url!.absoluteString)
            return
        }
        print("no link")
        decisionHandler(WKNavigationActionPolicy.allow)
        print("After" + webView.url!.absoluteString)
    }
}

