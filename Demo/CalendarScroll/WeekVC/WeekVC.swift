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
    @IBOutlet weak var myCollection: UICollectionView!
    
    var allDaysInMonth: [Date] = []
    var data : [EventMonth] = [EventMonth]()
    var currentPage: Date {
        let offsetX = myCollection.contentOffset.x
        let index = Int(offsetX/myCollection.bounds.width)
        return listMonth[index]
    }
    
    var listMonth: [Date] = [Date().addMonths(numberOfMonths: 3),
                             Date(),
                             Date().addMonths(numberOfMonths: 1),
                             Date().addMonths(numberOfMonths: 2),
                             Date().addMonths(numberOfMonths: 3),
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
        btnWeek.layer.cornerRadius = 8
        btnWeek.layer.masksToBounds = true
        btnWeek.backgroundColor = #colorLiteral(red: 0.1486144364, green: 0.2291531265, blue: 0.3167444468, alpha: 1)
    }
    //MARK: Button Function
    @IBAction func chooseDay(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    @IBAction func chooseWeek(_ sender: Any) {
        
    }
}

extension WeekVC: UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMonth.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellWeek", for: indexPath) as! CellWeek
        return cell
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("scrollViewDidEndScrollingAnimation")
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = myCollection.contentOffset.x
        
        if offsetX < scrollView.bounds.width {
            currentIndex = listMonth.count - 2
            print("prev index: \(currentIndex)")
            
            if offsetX == 0 {
                generatePrevDateData()
            }
            
            weak var weakSelf = self
            DispatchQueue.main.async {
                if let strongSelf = weakSelf {
                    //strongSelf.generatePrevDateData()
                    
                    strongSelf.myCollection.scrollToItem(at: IndexPath(row: strongSelf.currentIndex, section: 0), at: .left, animated: false)
                    //strongSelf.reloadMonthTitle()
                }
            }
        } else {
            var index: Int = Int(offsetX/scrollView.bounds.width)
            index = index >= listMonth.count ? listMonth.count - 1 : index
            print("next index: \(index)")
            
            weak var weakSelf = self
            if index == listMonth.count - 1 {
                DispatchQueue.main.async {
                    if let strongSelf = weakSelf {
                        strongSelf.generateNextDateData()
                        strongSelf.currentIndex = 1
                        strongSelf.myCollection.scrollToItem(at: IndexPath(row: strongSelf.currentIndex, section: 0), at: .left, animated: false)
                        //strongSelf.reloadMonthTitle()
                    }
                }
            }
            else  {
                currentIndex = index
                //reloadMonthTitle()
            }
        }
    }
    
    func generatePrevDateData() {
        let date = listMonth[1]
        
        print("generatePrevDateData month: \(date.month) - \(date.year)")
        
        let list: [Date] = [date.addMonths(numberOfMonths: -1),
                            date.addMonths(numberOfMonths: -4),
                            date.addMonths(numberOfMonths: -3),
                            date.addMonths(numberOfMonths: -2),
                            date.addMonths(numberOfMonths: -1),
                            date]

        listMonth = list
        myCollection.reloadData()
    }
    
    func generateNextDateData() {
        let date = listMonth[4]
        
        print("generateNextDateData month: \(date.month) - \(date.year)")
        
        let list: [Date] = [date.addMonths(numberOfMonths: -1),
                            date.addMonths(numberOfMonths: 1),
                            date.addMonths(numberOfMonths: 2),
                            date.addMonths(numberOfMonths: 3),
                            date.addMonths(numberOfMonths: 4),
                            date]

        listMonth = list
        myCollection.reloadData()
        
    }
    
}
