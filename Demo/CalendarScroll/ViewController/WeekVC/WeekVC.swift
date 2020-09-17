//
//  WeekVC.swift
//  Demo
//
//  Created by Apple on 9/15/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class WeekVC: UIViewController {

    @IBOutlet weak var viewButton: UIView!
    @IBOutlet weak var btnDay: UIButton!
    @IBOutlet weak var btnWeek: UIButton!
    @IBOutlet weak var btnMonth: UIButton!
    @IBOutlet weak var btnYear: UIButton!
    @IBOutlet weak var myCollection: UICollectionView!
    
    var allDaysInMonth: [Date] = []
    var data : [EventMonth] = [EventMonth]()
    var currentPage: Date {
        let offsetX = myCollection.contentOffset.x
        let index = Int(offsetX/myCollection.bounds.width)
        return listWeek[index]
    }
    
    var listWeek: [Date] = [Date().addWeeks(numberOfWeeks: 3),
                             Date(),
                             Date().addWeeks(numberOfWeeks: 1),
                             Date().addWeeks(numberOfWeeks: 2),
                             Date().addWeeks(numberOfWeeks: 3),
                             Date()]
                            
    
    var currentIndex: Int = 1
    var currentYear : Int = 0
    var currentMonth : Int = 0
    var currentDay : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let calendar = Calendar.current
        currentMonth = calendar.component(.month, from: date)
        currentYear = calendar.component(.year, from: date)
        currentDay = calendar.component(.day, from: date)
        
        
        conFig()
    }
    //MARK: Set Up
    func conFig(){
        myCollection.register(UINib.init(nibName: "CellWeek", bundle: nil), forCellWithReuseIdentifier: "CellWeek")
        
        viewButton.layer.cornerRadius = 8
        viewButton.layer.masksToBounds = true
        btnDay.layer.cornerRadius = 8
        btnDay.layer.masksToBounds = true
        btnDay.backgroundColor = #colorLiteral(red: 0.2765077651, green: 0.3295275569, blue: 0.3910240531, alpha: 1)
        btnMonth.layer.cornerRadius = 8
        btnMonth.layer.masksToBounds = true
        btnMonth.backgroundColor = #colorLiteral(red: 0.2765077651, green: 0.3295275569, blue: 0.3910240531, alpha: 1)
        btnYear.layer.cornerRadius = 8
        btnYear.layer.masksToBounds = true
        btnYear.backgroundColor = #colorLiteral(red: 0.2765077651, green: 0.3295275569, blue: 0.3910240531, alpha: 1)
        btnWeek.layer.cornerRadius = 8
        btnWeek.layer.masksToBounds = true
        btnWeek.backgroundColor = #colorLiteral(red: 0.1486144364, green: 0.2291531265, blue: 0.3167444468, alpha: 1)
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
}

extension WeekVC: UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return listMonth.count
        return listWeek.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellWeek", for: indexPath) as! CellWeek
        let date    = listWeek[indexPath.row]
        cell.currentMonth = date.month
        cell.currentYear = date.year
        cell.currentDay = date.day
        cell.loadData(currentDate: date)
        
        return cell
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = myCollection.contentOffset.x
        
        if offsetX < scrollView.bounds.width {
            currentIndex = listWeek.count - 2
            print("prev index: \(currentIndex)")
            
            if offsetX == 0 {
                generatePrevDateData()
            }
            
            weak var weakSelf = self
            DispatchQueue.main.async {
                if let strongSelf = weakSelf {
                    
                    strongSelf.myCollection.scrollToItem(at: IndexPath(row: strongSelf.currentIndex, section: 0), at: .left, animated: false)
                }
            }
        } else {
            var index: Int = Int(offsetX/scrollView.bounds.width)
            index = index >= listWeek.count ? listWeek.count - 1 : index
            print("next index: \(index)")
            
            weak var weakSelf = self
            if index == listWeek.count - 1 {
                DispatchQueue.main.async {
                    if let strongSelf = weakSelf {
                        strongSelf.generateNextDateData()
                        strongSelf.currentIndex = 1
                        strongSelf.myCollection.scrollToItem(at: IndexPath(row: strongSelf.currentIndex, section: 0), at: .left, animated: false)
                    }
                }
            }
            else  {
                currentIndex = index
            }
        }
    }
    
    func generatePrevDateData() {
        let date = listWeek[1]
        
        let list: [Date] = [date.addWeeks(numberOfWeeks: -1),
                            date.addWeeks(numberOfWeeks: -4),
                            date.addWeeks(numberOfWeeks: -3),
                            date.addWeeks(numberOfWeeks: -2),
                            date.addWeeks(numberOfWeeks: -1),
                            date]

        listWeek = list
        myCollection.reloadData()
    }
    
    func generateNextDateData() {
        let date = listWeek[4]
        
        let list: [Date] = [date.addWeeks(numberOfWeeks: -1),
                            date.addWeeks(numberOfWeeks: 1),
                            date.addWeeks(numberOfWeeks: 2),
                            date.addWeeks(numberOfWeeks: 3),
                            date.addWeeks(numberOfWeeks: 4),
                            date]

        listWeek = list
        myCollection.reloadData()
        
    }
    
}
