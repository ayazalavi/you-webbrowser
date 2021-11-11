//
//  ViewController.swift
//  Web Browser
//
//  Created by Ayaz Alavi on 09/11/2021.
//

import UIKit
import WebKit

class LandingPage: UIViewController {

    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var page: WKWebView!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var forward: UIButton!
    @IBOutlet weak var topBar: UIStackView!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var show: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        page.navigationDelegate = self
    }
    
    @IBAction func search(_ sender: Any) {
        if let text = url.text, text.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
           if let url = URL(string: text), text.isURL {
               page.load(URLRequest(url: url))
               setURL(pageurl: url)
           }
            else if let keyword = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                print("http://www.google.com/search?q=\(keyword)")
                let url = URL(string: "http://www.google.com/search?q=\(keyword)")!
                page.load(URLRequest(url: url))
                setURL(pageurl: url)
            }
        }
    }
    @IBAction func goBack(_ sender: Any) {
        page.goBack()
    }
    @IBAction func goForward(_ sender: Any) {
        page.goForward()
    }
    
    func setURL(pageurl: URL) {
        url.text = pageurl.absoluteString
    }
    
    func showBackForward() {
        back.isHidden = !page.canGoBack
        forward.isHidden = !page.canGoForward
    }
    
    func hideTopBar() {
        UIView.animate(
                    withDuration: 0.4,
                    delay: 0.0,
                    options: .curveEaseOut,
                    animations: {
                        self.leading.constant = -self.topBar.frame.size.width - 40
                        self.trailing.constant = self.topBar.frame.size.width + 40
                        self.view.layoutIfNeeded()
                }) { (completed) in
                    self.show.isHidden = false
                }
    }
    
    @IBAction func showTopBar(_ sender: Any) {
        UIView.animate(
                    withDuration: 0.4,
                    delay: 0.0,
                    options: .curveEaseOut,
                    animations: {
                        self.show.isHidden = true
                        self.leading.constant = 20
                        self.trailing.constant = 20
                        self.view.layoutIfNeeded()
                }) { (completed) in
                }
    }
    
}

extension LandingPage: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let url = webView.url else { return }
        setURL(pageurl: url)
        showBackForward()
        hideTopBar()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }
        setURL(pageurl: url)
        showBackForward()
    }
}
