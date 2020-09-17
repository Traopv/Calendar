//
//  CellYear.swift
//  Demo
//
//  Created by Apple on 9/16/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class CellYear: UICollectionViewCell {

    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    @IBOutlet weak var lbMonth: UILabel!
    @IBOutlet weak var myCollection: UICollectionView!
    var allDay : [Date] = [Date]()
    
//    var month : Int = 0
//    var year : Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: Setup
    func conFig(){
        myCollection.register(UINib.init(nibName: "CellMonthYear", bundle: nil), forCellWithReuseIdentifier: "CellMonthYear")
        
    }
    func loadData(month: Int,year: Int) {
        allDay = Utils.getDayInMonth(month: month, year: year)
        myCollection.reloadData()
    }
    func setUpCollectionViewItems(){
        if collectionViewFlowLayout == nil{
            let width : CGFloat = 465
            let height: CGFloat = 265
            let numberOfItemInRow : CGFloat = 7
            //let numberOfRow : CGFloat = 5
            let iLineSpaing : CGFloat = 5
            let interItemSpacing : CGFloat = 2.5
            let iWidth : CGFloat = 60// (width - (numberOfItemInRow - 1) * interItemSpacing) / numberOfItemInRow
            let iHeight : CGFloat = 49//(height - (numberOfRow - 1) * iLineSpaing) / numberOfRow
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: iWidth, height: iHeight)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.minimumLineSpacing = iLineSpaing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            
            myCollection.setCollectionViewLayout(collectionViewFlowLayout, animated : true)
        }
    }
}
extension CellYear: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allDay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellMonthYear", for: indexPath) as! CellMonthYear
        cell.lbDay.text = allDay[indexPath.row].toString(dateFormat: "dd")
        return cell
    }
}
