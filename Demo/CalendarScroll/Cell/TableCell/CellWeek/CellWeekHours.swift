//
//  CellWeekHours.swift
//  Demo
//
//  Created by Apple on 9/15/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class CellWeekHours: UITableViewCell {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK: Setup
    func conFig(){
        view1.layer.borderWidth = 1
        view2.layer.borderWidth = 1
        view3.layer.borderWidth = 1
        view4.layer.borderWidth = 1
        view5.layer.borderWidth = 1
        view6.layer.borderWidth = 1
        view7.layer.borderWidth = 1
    }
}
