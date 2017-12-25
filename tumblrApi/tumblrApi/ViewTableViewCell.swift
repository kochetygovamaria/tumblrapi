//
//  ViewTableViewCell.swift
//  tumblrApi
//
//  Created by Maria Kochetygova on 12/24/17.
//  Copyright © 2017 Maria Kochetygova. All rights reserved.
//

import UIKit

class ViewTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var blogSummaryLabel: UILabel!
    @IBOutlet weak var imageL: UIImageView!
    @IBOutlet weak var blogTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
