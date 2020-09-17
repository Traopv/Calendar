//
//  CellWeek.swift
//  Demo
//
//  Created by Apple on 9/15/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class CellWeek: UICollectionViewCell {

    @IBOutlet weak var myTable: UITableView!
    var allDaysInWeek : [Int] = [Int]()
    var currentYear = 0
    var currentMonth = 0
    var currentDay = 0
    //var currentDate : Date
    override func awakeFromNib() {
        super.awakeFromNib()
        
        conFig()
        //self.myTable.alwaysBounceHorizontal = false
//        self.myTable.contentSize = CGSize(width: self.myTable.frame.size.width, height: self.myTable.contentSize.height);
//        self.myTable.alwaysBounceHorizontal = false
//        self.myTable.alwaysBounceVertical = false
        
    }

    //MARK: Set up
    func conFig(){
        myTable.register(UINib.init(nibName: "CellWeekHours", bundle: nil), forCellReuseIdentifier: "CellWeekHours")
    }
    func loadData(currentDate : Date){
        allDaysInWeek = Utils.getAllDayWeek(date: currentDate, month: currentMonth, year: currentYear)
        myTable.reloadData()
    }
}

extension CellWeek: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 72
    }
    func tableView(_ tableView: UITableView,viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader  = DayInWeek().fromNib(nibName: "DayInWeek") as? DayInWeek
        viewHeader?.lbDate.text = "Th.\(currentMonth) - \(currentYear)"
        viewHeader?.allDayInWeek = allDaysInWeek
        viewHeader?.conFig()
       return viewHeader
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellHours = tableView.dequeueReusableCell(withIdentifier: "CellWeekHours", for: indexPath) as! CellWeekHours
        cellHours.conFig()
        cellHours.lbHours.text = "\(indexPath.row + 1):00"
        return cellHours
    }
    
    
}
