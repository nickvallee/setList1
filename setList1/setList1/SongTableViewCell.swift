//
//  SongTableViewCell.swift
//  setList1
//
//  Created by Nicolaas Vallee on 2016-06-09.
//  Copyright © 2016 Nicolaas Vallee. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    // MARK: Properties

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var songOrder: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
