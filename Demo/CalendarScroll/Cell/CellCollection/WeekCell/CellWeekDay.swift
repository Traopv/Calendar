//
//  CellWeekDay.swift
//  Demo
//
//  Created by Apple on 9/15/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class CellWeekDay: UICollectionViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lbDay: UILabel!
    @IBOutlet weak var lbStaft: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //MARK: Setup
    func conFig(){
        viewCell.layer.borderWidth = 1
        lbDay.layer.cornerRadius = lbDay.bounds.height/2
        lbDay.layer.masksToBounds = true
    }
}
