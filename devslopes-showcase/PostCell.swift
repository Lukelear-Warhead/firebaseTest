//
//  PostCell.swift
//  devslopes-showcase
//
//  Created by Luke Regan on 2/10/16.
//  Copyright © 2016 Luke Regan. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
	
	@IBOutlet weak var profileImg: UIImageView!
	@IBOutlet weak var showcaseImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	override func drawRect(rect: CGRect) {
		profileImg.layer.cornerRadius = profileImg.frame.size.width / 2
		profileImg.clipsToBounds = true
		
		showcaseImg.clipsToBounds = true

	}


}
