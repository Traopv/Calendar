//
//  MonthVCCell.swift
//  Demo
//
//  Created by Apple on 9/22/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class MonthVCCell: UICollectionViewCell {

    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    @IBOutlet weak var myCollection: UICollectionView!
    var allDaysInMonth : [Date] = []
    var month : Int = 0
    var year : Int = 0
    var data : [EventDay] = [EventDay]()
    var arrEvent : [Event] = [Event]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myCollection.register(UINib.init(nibName: "DayInMonthCell", bundle: nil), forCellWithReuseIdentifier: "DayInMonthCell")
        layoutSubviews()
        data = GetData.loadJson1()!
    }
    
    //MARK:-
    //MARK: funtion setup
    func loadData(){
        allDaysInMonth = Utils.getAllDateOfMonth(month: month, year: year)
        myCollection.reloadData()
    }
}

//MARK:-
extension MonthVCCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allDaysInMonth.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayInMonthCell", for: indexPath) as! DayInMonthCell
        //var dayAndMonth = allDaysInMonth[indexPath.row].toString(dateFormat: "dd-MM")
        let date = allDaysInMonth[indexPath.row] as Date
        
        let currentDate = Date()
        
        if (currentDate.day == date.day && currentDate.month == date.month && currentDate.year == date.year){
            cell.viewCell.backgroundColor = #colorLiteral(red: 0.1254955232, green: 0.168204397, blue: 0.2174127102, alpha: 1)
            cell.lbDay.backgroundColor = .red
        } else {
            cell.viewCell.backgroundColor = #colorLiteral(red: 0.1254955232, green: 0.168204397, blue: 0.2174127102, alpha: 1)
            cell.lbDay.backgroundColor = .clear
        }

        cell.lbDay.text = date.toString(dateFormat: "dd")
        
        if (date.month == month){
            //thang hien tai
            
            cell.lbDay.textColor = .white
            
        } else {
            //thang truoc hoac hoac thang sau
            cell.lbDay.textColor = .gray
        }
        // show su kien
        let event = GetData.findEvent1(value: date, in: self.data)
        if event != nil{
            cell.imgCell.isHidden = false
        } else  {
            cell.imgCell.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let date = allDaysInMonth[indexPath.row] as Date
        let  detailMonth : DetailMonth = DetailMonth().fromNib(nibName: "DetailMonth", index: 0) as! DetailMonth
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
extension MonthVCCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : CGFloat = myCollection.frame.width
        let height: CGFloat = myCollection.frame.height
        let numberOfItemInRow : CGFloat = 7
        let numberOfRow : CGFloat = 6
        let iLineSpaing : CGFloat = 1
        let interItemSpacing : CGFloat = 1
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
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
