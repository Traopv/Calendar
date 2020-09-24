//
//  DayInWeek.swift
//  Demo
//
//  Created by ELSAGA-MACOS on 9/15/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class DayInWeek: UIView {

    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbDay1: UILabel!
    @IBOutlet weak var lbDay2: UILabel!
    @IBOutlet weak var lbDay3: UILabel!
    @IBOutlet weak var lbDay4: UILabel!
    @IBOutlet weak var lbDay5: UILabel!
    @IBOutlet weak var lbDay6: UILabel!
    @IBOutlet weak var lbDay7: UILabel!
    private var lable_Arr = [UILabel]()
    var allDayInWeek : [Int] = [Int]()
    
    func fromNib(nibName : String, index : Int! = 0) -> UIView {
        let bundle = Bundle.main
        let nib = UINib(nibName: nibName, bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil)[index] as! UIView
        
        return nibView
    }
    
    //MARK:-
    //MARK: Setup
    func conFig(){
        let currentDate = Date()
        lable_Arr.append(lbDay1)
        lable_Arr.append(lbDay2)
        lable_Arr.append(lbDay3)
        lable_Arr.append(lbDay4)
        lable_Arr.append(lbDay5)
        lable_Arr.append(lbDay6)
        lable_Arr.append(lbDay7)
        
        for i in 0 ..< 7{
            let lb = lable_Arr[i]
            lb.layer.cornerRadius = lb.bounds.height / 2
            lb.layer.masksToBounds = true
            lb.text = String(allDayInWeek[i])
            if currentDate.day == allDayInWeek[i]{
                lb.backgroundColor = .red
            }
        }
    }
}
