//
//  CellTableWeek.swift
//  Demo
//
//  Created by Apple on 9/15/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class CellTableWeek: UITableViewCell {

     var collectionViewFlowLayout : UICollectionViewFlowLayout!
    @IBOutlet weak var myCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        conFig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    //MARK: Setup
    func conFig(){
        myCollection.register(UINib.init(nibName: "CellWeekDay", bundle: nil), forCellWithReuseIdentifier: "CellWeekDay")
    }
    
    func setUpCollectionViewItems(){
        if collectionViewFlowLayout == nil{
            let width : CGFloat = 896
            let height: CGFloat = 70
            let numberOfItemInRow : CGFloat = 7
            let numberOfRow : CGFloat = 1
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
        }
    }
}
extension CellTableWeek: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellWeekDay", for: indexPath) as! CellWeekDay
        cell.conFig()
        return cell
    }
    
    
}
