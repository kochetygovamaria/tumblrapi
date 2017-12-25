//
//  ViewController.swift
//  tumblrApi
//
//  Created by Maria Kochetygova on 12/24/17.
//  Copyright © 2017 Maria Kochetygova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var postView: UIWebView!
    var postSelected:Post?
    override func viewDidLoad() {
        super.viewDidLoad()
        postView.loadRequest(displayPost(postSelected!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func displayPost(_ post:Post)->URLRequest{
        var request:URLRequest?
        if let url=URL(string:post.url){
            request=URLRequest(url:url)
        }
       
        return request!
    }
    

}

