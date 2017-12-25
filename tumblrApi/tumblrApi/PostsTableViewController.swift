//
//  PostsTableViewController.swift
//  tumblrApi
//
//  Created by Maria Kochetygova on 12/24/17.
//  Copyright © 2017 Maria Kochetygova. All rights reserved.
//

import UIKit

class PostsTableViewController: UITableViewController {
    var posts:[Post]=[]
    let url="https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
    override func viewDidLoad() {
        super.viewDidLoad()

        loadPost(url: url){
        (posts)in
            self.posts=posts
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)as! ViewTableViewCell
      
        // Configure the cell...
        let post:Post=posts[indexPath.row]
        cell.blogTitleLabel.text=removeIphen(string:post.slug)
        cell.blogSummaryLabel.text=removeIphen(string:post.summary)
        cell.dateLabel.text=post.date
        downloadImage(urlString:post.image){
            (data) in
            
            cell.imageL.image=UIImage(data:data)
        }
        
        
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let postVC=segue.destination as! ViewController
        let indexPath=tableView.indexPathForSelectedRow
        let post=posts[indexPath!.row]
        postVC.postSelected=post
    }
    func removeIphen(string:String)->String{
       return (string.replacingOccurrences(of:"-", with: " ")).capitalized
    }

    
    

}


extension PostsTableViewController{
    func downloadPost(urlString:String,completion:@escaping (_ posts:[Dictionary<String,Any>])->()){
        let url=URL(string:urlString)
        var allPost:[Dictionary<String,Any>] = []
        let request=URLRequest(url:url!)
        let session=URLSession(configuration:URLSessionConfiguration.default,
                               delegate:nil,
                               delegateQueue:OperationQueue.main)
        let task:URLSessionDataTask=session.dataTask(with:request){
            (data,response, error)in
    
        if error==nil{
            if let responseDictionary=try!JSONSerialization.jsonObject(with:data!, options:[])as? NSDictionary{
                let responseDict = responseDictionary["response"] as! NSDictionary
                allPost = responseDict["posts"] as! [NSDictionary] as! [Dictionary<String, Any>]
          
          
        
                  }
            else{
                print("error processing")
                print(error!.localizedDescription)
                }
            }
            DispatchQueue.main.async{
            completion(allPost)
        }
        }
          task.resume()
    
    }
        func loadPost(url:String, completion:@escaping (_ posts:[Post])->()){
        
         var postObject:[Post]=[]
        downloadPost(urlString: url){(dicts)in
            for post in dicts{
               
                print(post["slug"] as! String)
                let id=post["id"] as! Int
                let slug=post["slug"] as! String
                let timeStamp=post["timestamp"] as! Int
                let url = post["post_url"] as! String
                let caption=post["caption"] as! String
                let summary=post["summary"] as! String
                let shortUrl=post["short_url"] as! String
                let image=self.getPhoto(post)
                let newPost=Post(id:id, slug: slug, date:self.formatDate(timestamp: timeStamp), summary: summary, caption: caption, url: url, shortUrl: shortUrl, image:image )
                postObject.append(newPost)
        }
           
         completion(postObject)
        }
           
    }
    
    
    func getPhoto(_ dict:Dictionary<String, Any>)->String{
        var postImage:String?
        let photo=dict["photos"] as? [Dictionary<String, Any>]
        let imageDict0=photo![0]
        let imageDict=imageDict0["original_size"] as! Dictionary<String, Any>
        postImage=imageDict["url"] as! String
        return postImage!
    }
    
    func downloadImage(urlString:String, completion:@escaping (_ data:Data)->()){
        var blogImgae:Data?
        
        let url=URL(string:urlString)
        let request=URLRequest(url:url!)
        let session=URLSession(configuration:URLSessionConfiguration.default,
                               delegate:nil,
                               delegateQueue:OperationQueue.main)
        let task:URLSessionDataTask=session.dataTask(with:request){
            (data,response, error)in
            
            if error==nil{
                if let dataOk=data{
                    DispatchQueue.main.async{
                        completion(dataOk)
                    }
                    
                }
                else{
                    print("error processing data")
                    print(error!.localizedDescription)
                }
            }
            
        }
        task.resume()
    }
    
    
    func formatDate(timestamp:Int)->String{
        let date0 = NSDate(timeIntervalSince1970:TimeInterval(timestamp))
        let dateFormatter=DateFormatter()
        dateFormatter.dateFormat="MMM d, yyyy"
        return dateFormatter.string(from:date0 as Date)
    }
  
}
