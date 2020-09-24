//
//  CellDate.swift
//  Demo
//
//  Created by ELSAGA-MACOS on 9/10/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class CellDate: UICollectionViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lbDay: UILabel!
    @IBOutlet weak var imgCell: UIImageView!
    
    let currentDate = Date()
    var date = Date()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewCell.layer.cornerRadius = 7
        viewCell.layer.masksToBounds = true
    }

    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                self.viewCell!.backgroundColor = .red
            } else {
                self.viewCell!.backgroundColor = .clear
            }
        }
    }
}
