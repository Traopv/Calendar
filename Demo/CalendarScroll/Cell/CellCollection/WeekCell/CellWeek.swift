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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        conFig()
    }

    //MARK: Set up
    func conFig(){
        myTable.register(UINib.init(nibName: "CellTableWeek", bundle: nil), forCellReuseIdentifier: "CellTableWeek")
        myTable.register(UINib.init(nibName: "CellWeekHours", bundle: nil), forCellReuseIdentifier: "CellWeekHours")
    }
}

extension CellWeek: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "CellTableWeek", for: indexPath) as! CellTableWeek
        let cellHours = tableView.dequeueReusableCell(withIdentifier: "CellWeekHours", for: indexPath) as! CellWeekHours
        
//        if indexPath.row == 0 {
//            cell.setUpCollectionViewItems()
//            return cell
//        }
//        else{
//            return cellHours
//        }
        return cellHours
    }
    
    
}
