//
//  CellCalendar.swift
//  Demo
//
//  Created by ELSAGA-MACOS on 9/11/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class CellCalendar: UICollectionViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lbDay: UILabel!
    @IBOutlet weak var imgCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewCell.layer.cornerRadius = 5
        viewCell.layer.masksToBounds = true
        imgCell.isHidden = true
    }

}
