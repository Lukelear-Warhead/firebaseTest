//
//  DataService.swift
//  devslopes-showcase
//
//  Created by Luke Regan on 2/7/16.
//  Copyright © 2016 Luke Regan. All rights reserved.
//

import Foundation
import Firebase

let URL_BASE = "https://luketest.firebaseio.com"

class DataSerice {
	
	static let ds = DataSerice()
	
	private var _REF_BASE = Firebase(url: "\(URL_BASE)")
	private var _REF_POSTS = Firebase(url: "\(URL_BASE)/posts")
	private var _REF_USERS = Firebase(url: "\(URL_BASE)/users")
	
	var REF_BASE: Firebase { return _REF_BASE }
	var REF_POSTS: Firebase { return _REF_POSTS }
	var REF_USERS: Firebase { return _REF_USERS }
	
	func createFirebaseUser(uid: String, user: [String: String]) {
		REF_USERS.childByAppendingPath(uid).setValue(user)
	}
	
}