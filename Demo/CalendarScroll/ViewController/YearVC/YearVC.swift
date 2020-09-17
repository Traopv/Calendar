//
//  YearVC.swift
//  Demo
//
//  Created by Apple on 9/16/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class YearVC: UIViewController {

    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    @IBOutlet weak var viewButton: UIView!
    @IBOutlet weak var btnDay: UIButton!
    @IBOutlet weak var btnWeek: UIButton!
    @IBOutlet weak var btnMonth: UIButton!
    @IBOutlet weak var btnYear: UIButton!
    @IBOutlet weak var myCollection: UICollectionView!
    @IBOutlet weak var btnPrevYear: UIButton!
    @IBOutlet weak var btnNextYear: UIButton!
    
    let date = Date()
    let calendar = Calendar.current
    var allMonths = [1,2,3,4,5,6,7,8,9,11,12]
    var currentMonth : Int = 0
    var currentYear : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        conFig()
        currentMonth = calendar.component(.month, from: date)
        currentYear = calendar.component(.year, from: date)
        print("currentMonth",currentMonth)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpCollectionViewItems()
    }
    
    //MARK: SetUp
    func conFig(){
        myCollection.register(UINib.init(nibName: "CellYear", bundle: nil), forCellWithReuseIdentifier: "CellYear")
    }
    
    func setUpCollectionViewItems(){
        if collectionViewFlowLayout == nil{
            let width : CGFloat = 984
            let height: CGFloat = 573
            let numberOfItemInRow : CGFloat = 2
            //let numberOfRow : CGFloat = 0
            let iLineSpaing : CGFloat = 20
            let interItemSpacing : CGFloat = 20
            let iWidth = (width - (numberOfItemInRow - 1) * interItemSpacing) / numberOfItemInRow
            let iHeight : CGFloat = 350//(height - (numberOfRow - 1) * iLineSpaing) / numberOfRow
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: iWidth, height: iHeight)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.minimumLineSpacing = iLineSpaing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            
            myCollection.setCollectionViewLayout(collectionViewFlowLayout, animated : true)
        }
    }
    //MARK: Button Function
    @IBAction func chooseDay(_ sender: Any) {
        let dayVC = CalendarViewController.init()
        self.navigationController?.pushViewController(dayVC, animated: false)
    }
    @IBAction func chooseWeek(_ sender: Any) {
        
    }
    @IBAction func btnChooseMonth(_ sender: Any) {
        let monthVC = MonthVC.init()
        self.navigationController?.pushViewController(monthVC, animated: false)
    }
    @IBAction func btnChooseYear(_ sender: Any) {
    }
    @IBAction func prevYear(_ sender: Any) {
        currentYear -= 1
    }
    @IBAction func nextYear(_ sender: Any) {
        currentYear += 1
    }
}
extension YearVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellYear", for: indexPath) as! CellYear
        cell.conFig()
        cell.setUpCollectionViewItems()
        cell.loadData(month: allMonths[indexPath.row],year: currentYear)
        cell.lbMonth.text = "Tháng \(allMonths[indexPath.row])"
        return cell
    }
}
