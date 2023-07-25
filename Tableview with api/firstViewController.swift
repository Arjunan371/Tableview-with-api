//
//  firstViewController.swift
//  Tableview with api
//
//  Created by Mohammed Abdullah on 13/07/23.
//

import UIKit
import WebKit
class firstViewController: UIViewController {
    var webiew:String = ""
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: webiew ?? "" ) {
            // Create a URLRequest object
            let request = URLRequest(url: url)
            
            // Load the request in the webView
            DispatchQueue.main.async {
                self.webView.load(request)
            }
        }
        
        
    }

}
