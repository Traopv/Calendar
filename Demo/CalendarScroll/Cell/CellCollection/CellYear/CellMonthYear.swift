//
//  CellMonthYear.swift
//  Demo
//
//  Created by Apple on 9/16/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class CellMonthYear: UICollectionViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lbDay: UILabel!
    @IBOutlet weak var imgCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK:-
    //MARK: Setup
    func conFig(){
        viewCell.layer.cornerRadius = 5
        viewCell.layer.masksToBounds = true
    }
}
