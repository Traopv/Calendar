//
//  DayInMonthCell.swift
//  Demo
//
//  Created by Apple on 9/22/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class DayInMonthCell: UICollectionViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lbDay: UILabel!
    @IBOutlet weak var imgCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lbDay.layer.cornerRadius = lbDay.bounds.height / 2
        lbDay.layer.masksToBounds = true
    }

}
