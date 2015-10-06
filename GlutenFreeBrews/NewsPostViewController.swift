//
//  NewsPostViewController.swift
//  GF Brews
//
//  Created by Sam on 10/6/15.
//  Copyright © 2015 Sam Galizia. All rights reserved.
//

import UIKit
import Parse

class NewsPostViewController: UIViewController {
  
  // Variables & Outlets
  var post: PFObject?
  
  
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    // Set the navigationBar text attributes
    let attributesDictionary = [
      NSFontAttributeName: UIFont(name: "Pacifico-Regular", size: 34)!,
      NSForegroundColorAttributeName: UIColor(red: 0.92, green: 0.55, blue: 0.01, alpha: 1.0)]
    self.navigationController?.navigationBar.titleTextAttributes = attributesDictionary
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
}
