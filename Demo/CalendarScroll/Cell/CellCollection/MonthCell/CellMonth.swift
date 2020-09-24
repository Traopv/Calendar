//
//  CellMonth.swift
//  Demo
//
//  Created by ELSAGA-MACOS on 9/16/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class CellMonth: UICollectionViewCell {

    @IBOutlet weak var lbDay: UILabel!
    @IBOutlet weak var lbEvent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK:-
    //MARK: Setup
    func conFig(){
        lbDay.layer.cornerRadius = lbDay.bounds.height / 2
        lbDay.layer.masksToBounds = true
    }
}
