//
//  TableViewCell.swift
//  FlickPhotoLoad
//
//  Created by Prakhar Tripathi on 10/01/18.
//  Copyright © 2018 Prakhar Tripathi. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageButton: UIButton!
    @IBOutlet weak var rightImageButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
