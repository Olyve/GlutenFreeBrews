//
//  NewsViewController.swift
//  GF Brews
//
//  Created by Sam on 10/5/15.
//  Copyright © 2015 Sam Galizia. All rights reserved.
//

import UIKit
import Parse

class NewsViewController: UIViewController {
  
  // Variables & Outlets
  var newsPosts: [PFObject] = []
  var refreshControl: UIRefreshControl!
  let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
  
  @IBOutlet weak var navTitle: UINavigationItem!
  @IBOutlet weak var tableView: UITableView!
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    // Add the refreshControl
    tableView.addSubview(refreshControl)
    
    // Set the navigationBar text attributes
    let attributesDictionary = [
                 NSFontAttributeName: UIFont(name: "Pacifico-Regular", size: 34)!,
      NSForegroundColorAttributeName: UIColor(red: 0.92, green: 0.55, blue: 0.01, alpha: 1.0)]
    self.navigationController?.navigationBar.titleTextAttributes = attributesDictionary
    
    // Query for NewsPosts
    queryParseForPosts()
    
    // Refresh the tableView
    tableView.reloadData()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Set up the refresh control and add it to the tableView
    refreshControl = UIRefreshControl()
    refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
    refreshControl.translatesAutoresizingMaskIntoConstraints = false
  }
  
  // Refresh function for pull to refresh
  func refresh(sender: AnyObject) {
    queryParseForPosts()
    tableView.reloadData()
    self.refreshControl.endRefreshing()
  }
}

// MARK: UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    let postViewController: NewsPostViewController = mainStoryboard.instantiateViewControllerWithIdentifier("NewsPostVC") as! NewsPostViewController
    postViewController.post = newsPosts[indexPath.row]
    self.navigationController?.presentViewController(postViewController, animated: true, completion: nil)
    
  }
}

// MARK: UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return newsPosts.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("NewsPostCell", forIndexPath: indexPath)
    
    // Set the title and the text of the cell to that of the post
    cell.textLabel?.text = newsPosts[indexPath.row]["postTitle"] as? String
    cell.detailTextLabel?.text = newsPosts[indexPath.row]["postText"] as? String
    
    return cell
  }
  
}

// MARK: Parse Queries and Logic
extension NewsViewController {
  
  func queryParseForPosts() {
    let query: PFQuery = PFQuery(className: "News_Post")
    query.limit = 10
    query.addAscendingOrder("createdAt")
    query.findObjectsInBackgroundWithBlock {
      (objects: [PFObject]?, error: NSError?) -> Void in
      if error == nil {
        guard let objects = objects as [PFObject]? else {
          // Handle error here
          print("Error: \(error?.description)")
          return
        }
        self.newsPosts = objects
      }
    }
  }
  
}



