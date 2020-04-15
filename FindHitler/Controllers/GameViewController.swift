//
//  ViewController.swift
//  FindHitler
//
//  Created by John Choi on 6/28/19.
//  Copyright © 2019 John Choi. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class GameViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var blocker: UIImageView!
    @IBOutlet weak var webkit: WKWebView!
    @IBOutlet weak var scoreLbl: UILabel!
    
    // current score
    var score = 0
    
    /// Initial set up for this controller
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let urlAddress = URL(string: "https://en.wikipedia.org/wiki/Special:Random") // start point
        let url = URLRequest(url: urlAddress!)
        webkit?.load(url)
        webkit.navigationDelegate = self
        webkit.allowsBackForwardNavigationGestures = true // for debugging only
        
        scoreLbl.text = String(format: "Score: %d", score)
        blocker.isHidden = true
    }
    
    /// Defines the behavior for the reset button.
    /// - Parameters: sender the source of the action
    @IBAction func resetBtnActivated(_ sender: UIButton) {
        let urlAddress = URL(string: "https://en.wikipedia.org/wiki/Special:Random") // start point
        let url = URLRequest(url: urlAddress!)
        webkit?.load(url)
        webkit.navigationDelegate = self
        webkit.allowsBackForwardNavigationGestures = true // for debugging only
        
        webkit.isUserInteractionEnabled = true
        score = 0
        scoreLbl.text = String(format: "Score: %d", score)
        blocker.isHidden = true
    }
    
    /// WebKit Delegate function.
    /// Called everytime the player clicks on the link.
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("Clicked link " + navigationAction.request.url!.absoluteString)
        
        
//        print("touched")
//
//           // Get the specific point that was touched
//           let point: CGPoint? = sender?.location(in: view)
//
//           webView.evaluateJavaScript("document.getElementById(\"hdfUserId\").value") {(response, error) in
//               if (response != nil) {
//                   let title = response as! String
//                   print(title)
//               }
//               // error handling
//           }
//        
        
        
        
        let currentUrl = navigationAction.request.url!.absoluteString
        // check if the loading page is the target page
        if currentUrl == "https://en.m.wikipedia.org/wiki/Adolf_Hitler" {
            // if target page, display a score dialog
            let alert = UIAlertController(title: "Congratulations!", message: String(format: "You won with a score of %d!", score), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            decisionHandler(.allow)
            webkit.isUserInteractionEnabled = false
            blocker.isHidden = false
            return
        }
        
        // if not the target page
        // if the clicked link is hyperlink
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            print("link")
            score += 1
            
            scoreLbl.text = String(format: "Score: %d", score)
            decisionHandler(WKNavigationActionPolicy.allow)
        } else {
            print("no link")
            decisionHandler(WKNavigationActionPolicy.allow)
        }
    }
}
