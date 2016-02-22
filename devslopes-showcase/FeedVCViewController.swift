//
//  FeedVCViewController.swift
//  devslopes-showcase
//
//  Created by Luke Regan on 2/10/16.
//  Copyright © 2016 Luke Regan. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.dataSource = self
		tableView.delegate = self

		DataSerice.ds.REF_POSTS.observeEventType(.Value) { (snapshot) -> Void in
			
		}
		
    }



}

extension FeedVC: UITableViewDataSource {
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostCell
		
		return cell
	}
	
}


extension FeedVC: UITableViewDelegate {
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
	}
	
}