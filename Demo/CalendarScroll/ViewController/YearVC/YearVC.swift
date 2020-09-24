//
//  YearVC.swift
//  Demo
//
//  Created by Apple on 9/16/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class YearVC: UIViewController {

    @IBOutlet weak var viewButton: UIView!
    @IBOutlet weak var btnDay: UIButton!
    @IBOutlet weak var btnWeek: UIButton!
    @IBOutlet weak var btnMonth: UIButton!
    @IBOutlet weak var btnYear: UIButton!
    @IBOutlet weak var myCollection: UICollectionView!
    @IBOutlet weak var btnPrevYear: UIButton!
    @IBOutlet weak var btnNextYear: UIButton!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var btnToDay: UIButton!
    
    let date = Date()
    let calendar = Calendar.current
    var allMonths = [1,2,3,4,5,6,7,8,9,10,11,12]
    var currentMonth : Int = 0
    var currentYear : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conFig()
        currentMonth = calendar.component(.month, from: date)
        currentYear = calendar.component(.year, from: date)
        lbYear.text = String(currentYear)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    //MARK:-
    //MARK: SetUp
    func conFig(){
        btnNextYear.layer.cornerRadius = 5
        btnNextYear.layer.masksToBounds = true
        btnPrevYear.layer.cornerRadius = 5
        btnPrevYear.layer.masksToBounds = true
        btnToDay.layer.cornerRadius = 5
        btnToDay.layer.masksToBounds = true
        
        viewButton.layer.cornerRadius = 8
        viewButton.layer.masksToBounds = true
        btnDay.layer.cornerRadius = 8
        btnDay.layer.masksToBounds = true
        btnMonth.layer.cornerRadius = 8
        btnWeek.layer.masksToBounds = true
        btnWeek.layer.cornerRadius = 8
        btnYear.layer.masksToBounds = true
        btnYear.layer.cornerRadius = 8
        btnMonth.layer.masksToBounds = true
        btnDay.backgroundColor = #colorLiteral(red: 0.279307127, green: 0.3288925588, blue: 0.3904538155, alpha: 1)
        btnWeek.backgroundColor = #colorLiteral(red: 0.279307127, green: 0.3288925588, blue: 0.3904538155, alpha: 1)
        btnMonth.backgroundColor = #colorLiteral(red: 0.279307127, green: 0.3288925588, blue: 0.3904538155, alpha: 1)
        btnYear.backgroundColor = #colorLiteral(red: 0.1477420032, green: 0.232701242, blue: 0.3159016967, alpha: 1)
        
        myCollection.register(UINib.init(nibName: "CellYear", bundle: nil), forCellWithReuseIdentifier: "CellYear")
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
       if gesture.direction == .right {
            currentYear -= 1
            lbYear.text = String(currentYear)
            myCollection.reloadData()
       } else if gesture.direction == .left {
            currentYear += 1
            lbYear.text = String(currentYear)
            myCollection.reloadData()
       }
    }
    
    //MARK:-
    //MARK: Button Function
    @IBAction func chooseDay(_ sender: Any) {
        let dayVC = CalendarViewController.init()
        self.navigationController?.pushViewController(dayVC, animated: false)
    }
    
    @IBAction func chooseWeek(_ sender: Any) {
        let weekVC = WeekVC.init()
        self.navigationController?.pushViewController(weekVC, animated: false)
    }
    
    @IBAction func btnChooseMonth(_ sender: Any) {
        let monthVC = MonthViewController.init()
        self.navigationController?.pushViewController(monthVC, animated: false)
    }
    
    @IBAction func btnChooseYear(_ sender: Any) {
    }
    
    @IBAction func prevYear(_ sender: Any) {
        currentYear -= 1
        lbYear.text = String(currentYear)
        myCollection.reloadData()
    }
    
    @IBAction func nextYear(_ sender: Any) {
        currentYear += 1
        lbYear.text = String(currentYear)
        myCollection.reloadData()
    }
    
    @IBAction func chooseToDay(_ sender: Any) {
        let date = Date()
        currentMonth = date.month
        currentYear = date.year
        lbYear.text = String(currentYear)
        myCollection.reloadData()
    }
}

//MARK:-
extension YearVC: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellYear", for: indexPath) as! CellYear
        cell.conFig()
        cell.loadData(month: allMonths[indexPath.row],year: currentYear)
        cell.lbMonth.text = "Tháng \(allMonths[indexPath.row])"
        cell.currentMonth = allMonths[indexPath.row]
        cell.currentYear = currentYear
        return cell
    }
}

//MARK:-
extension YearVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : CGFloat = myCollection.frame.width
        let height: CGFloat = myCollection.frame.height
        let numberOfItemInRow : CGFloat = 4
        let numberOfRow : CGFloat = 3
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
