//
//  CellYear.swift
//  Demo
//
//  Created by Apple on 9/16/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class CellYear: UICollectionViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lbMonth: UILabel!
    @IBOutlet weak var myCollection: UICollectionView!
    var allDay : [Date] = [Date]()
    
    var currentMonth : Int = 0
    var currentYear : Int = 0
    var data : [EventDay] = [EventDay]()
    var arrEvent : [Event] = [Event]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    //MARK:-
    //MARK: Setup
    func conFig() {
        viewCell.layer.borderWidth = 1
        viewCell.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        viewCell.layer.cornerRadius = 8
        viewCell.layer.masksToBounds = true
        myCollection.register(UINib.init(nibName: "CellMonthYear", bundle: nil), forCellWithReuseIdentifier: "CellMonthYear")
        myCollection.register(UINib.init(nibName: "CellMonthYear", bundle: nil), forCellWithReuseIdentifier: "CellMonthYear")
        data = GetData.loadJson1()!
        
    }
    
    func loadData(month: Int,year: Int) {
        allDay = Utils.getDayInMonth(month: month, year: year)
        myCollection.reloadData()
    }
}

//MARK:-
extension CellYear: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allDay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellMonthYear", for: indexPath) as! CellMonthYear
        let date = allDay[indexPath.row]
        cell.lbDay.text = allDay[indexPath.row].toString(dateFormat: "dd")
        cell.conFig()
        let currentDate = Date()
        if (currentDate.day == date.day && currentDate.month == date.month && currentDate.year == date.year) {
            cell.viewCell.backgroundColor = .red
        } else {
            cell.viewCell.backgroundColor = .clear
        }

        if (date.month == currentMonth) {
            //thang hien tai
            cell.isHidden = false
            
        } else {
            //thang truoc hoac hoac thang sau
            cell.isHidden = true
        }
        let event = GetData.findEvent1(value: date, in: self.data)
        if event != nil {
            cell.imgCell.isHidden = false
        } else {
            cell.imgCell.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellMonthYear", for: indexPath) as! CellMonthYear
        let  detailMonth : DetailMonth = DetailMonth().fromNib(nibName: "DetailMonth", index: 0) as! DetailMonth
        let date = allDay[indexPath.row]
        arrEvent = GetData.findEvent1(value: date, in: data)!
        detailMonth.currentDate = date
        detailMonth.arrEvent = arrEvent
        detailMonth.conFig()
        let klc = KLCPopup.init(contentView: detailMonth)
        klc?.showType = .bounceInFromLeft
        klc?.dismissType = .bounceOutToTop
        klc?.maskType = .dimmed
        klc?.shouldDismissOnBackgroundTouch = true
        klc?.show()
    }
}

//MARK:-
extension CellYear: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : CGFloat = myCollection.frame.width
        let height: CGFloat = myCollection.frame.height
        let numberOfItemInRow : CGFloat = 7
        let numberOfRow : CGFloat = 6
        let iLineSpaing : CGFloat = 2.5
        let interItemSpacing : CGFloat = 2.5
        let iWidth = (width - (numberOfItemInRow - 1) * interItemSpacing) / numberOfItemInRow
        let iHeight = (height - (numberOfRow - 1) * iLineSpaing) / numberOfRow
        return CGSize(width: iWidth, height: iHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.5
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.5
    }
}
