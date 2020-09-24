//
//  CellCollectionViewCell.swift
//  Demo
//
//  Created by ELSAGA-MACOS on 9/10/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class CellCollectionViewCell: UICollectionViewCell {

    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    @IBOutlet weak var myCollection: UICollectionView!
    var allDaysInMonth : [Date] = []
    var month : Int = 0
    var year : Int = 0
    var data : [EventDay] = [EventDay]()
    
    var closureShowEvent: ((_ date : Date) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myCollection.register(UINib.init(nibName: "CellDate", bundle: nil), forCellWithReuseIdentifier: "CellDate")
        setUpCollectionViewItems()
        layoutSubviews()
    }
    
    //MARK:-
    //MARK: funtion setup
    func setUpCollectionViewItems(){
        if collectionViewFlowLayout == nil{
            let width : CGFloat = 455
            let height: CGFloat = 300
            let numberOfItemInRow : CGFloat = 7
            let numberOfRow : CGFloat = 6
            let iLineSpaing : CGFloat = 0
            let interItemSpacing : CGFloat = 0
            let iWidth = (width - (numberOfItemInRow - 1) * interItemSpacing) / numberOfItemInRow
            let iHeight = (height - (numberOfRow - 1) * iLineSpaing) / numberOfRow
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: iWidth, height: iHeight)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.minimumLineSpacing = iLineSpaing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            
            myCollection.setCollectionViewLayout(collectionViewFlowLayout, animated : true)
            
            data = GetData.loadJson1()!
        }
    }
    
    func loadData(){
        allDaysInMonth = Utils.getAllDateOfMonth(month: month, year: year)
        myCollection.reloadData()
    }
}

extension CellCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allDaysInMonth.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellDate", for: indexPath) as! CellDate
        let date = allDaysInMonth[indexPath.row] as Date
        
        let currentDate = Date()
        if (currentDate.day == date.day && currentDate.month == date.month && currentDate.year == date.year){
            cell.viewCell.backgroundColor = .red
        } else {
            cell.viewCell.backgroundColor = .clear
        }

        cell.lbDay.text = date.toString(dateFormat: "dd")
        cell.date = date
        
        if (date.month == month) {
            //thang hien tai
            
            cell.lbDay.textColor = .white
            
        } else {
            //thang truoc hoac hoac thang sau
            cell.lbDay.textColor = .gray
        }
        // show su kien
        let event = GetData.findEvent1(value: date, in: data)
        if event != nil {
            cell.imgCell.isHidden = false
        } else {
            cell.imgCell.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellDate", for: indexPath) as! CellDate
        let date = allDaysInMonth[indexPath.row] as Date
        closureShowEvent?(date)
        cell.isSelected = true
    }
}

//MARK:-
extension CellCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : CGFloat = myCollection.bounds.width
        let height: CGFloat = myCollection.bounds.height
        let numberOfItemInRow : CGFloat = 7
        let numberOfRow : CGFloat = 6
        let iLineSpaing : CGFloat = 1
        let interItemSpacing : CGFloat = 0.5
        let iWidth = (width - (numberOfItemInRow - 1) * interItemSpacing) / numberOfItemInRow
        let iHeight = (height - (numberOfRow - 1) * iLineSpaing) / numberOfRow
        
        collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: iWidth, height: iHeight)
        collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = iLineSpaing
        collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
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
        return 1.0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
}
