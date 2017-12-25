//
//  Post.swift
//  tumblrApi
//
//  Created by Maria Kochetygova on 12/24/17.
//  Copyright © 2017 Maria Kochetygova. All rights reserved.
//

import Foundation



class Post{
    var id:Int
    var slug:String
    var date:String
    var summary:String
    var caption:String?
    var url:String
    var shortUrl:String
    var image:String
    
    init(id:Int, slug:String, date:String, summary:String, caption:String,url:String,
         shortUrl:String, image:String){
        self.id=id
        self.caption=caption
        self.slug=slug
        self.date=date
        self.summary=summary
        self.url=url
        self.shortUrl=shortUrl
        self.image=image
        
    }
}
