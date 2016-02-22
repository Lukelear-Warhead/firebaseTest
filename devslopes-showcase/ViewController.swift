//
//  ViewController.swift
//  devslopes-showcase
//
//  Created by Luke Regan on 2/7/16.
//  Copyright © 2016 Luke Regan. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {
	
	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
			self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
		}
	}
	
	
	@IBAction func fbButtonPressed(sender: UIButton) {
		let facebookLogin = FBSDKLoginManager()
		facebookLogin.logInWithReadPermissions(["email"], fromViewController: self) { (result, error) -> Void in
			if error != nil {
				print("Facebook login failed. error \(error.debugDescription)")
			} else {
				let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
				print("Successfully loggin in with facebook \(accessToken)")
				
				DataSerice.ds.REF_BASE.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { (error, data) -> Void in
					
					if error != nil {
						print("Login failed \(error)")
					} else {
						print("Logged in \(data)")
						
						let user = ["provider": data.provider!, "blah" : "Test"]
						DataSerice.ds.createFirebaseUser(data.uid, user: user)
						
						NSUserDefaults.standardUserDefaults().setValue(data.uid, forKey: KEY_UID)
						self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
					}
				})
			}
		}
	}
	
	
	@IBAction func attemptLogin(sender: UIButton) {
		if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != "" {
			DataSerice.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: { (error, data) -> Void in
				if error != nil {
					if error.code == STATUS_ACCOUNT_NONEXIST {
						DataSerice.ds.REF_BASE.createUser(email, password: pwd, withValueCompletionBlock: { (error, result) -> Void in
							if error != nil {
								self.showAlert("Could not create account", message: "Problem creating account. Please try again")
							} else {
								NSUserDefaults.standardUserDefaults().setValue(result[KEY_UID], forKey: KEY_UID)
								DataSerice.ds.REF_BASE.authUser(email, password: pwd) { error, data in
									if error == nil {
										let user = ["provider": data.provider!, "blah": "emailtest"]
										DataSerice.ds.createFirebaseUser(data.uid, user: user)
									}
								}
								self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
							}
						})
					} else {
						self.showAlert("Could not create account", message: "Problem creating account. Please try something else")
					}
				} else {
					self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
				}
			})
		} else {
			showAlert("Email and password Required", message: "You must enter an email and password")
		}
	}
	
	func showAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
		presentViewController(alert, animated: true, completion: nil)
	}



}


























