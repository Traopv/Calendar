//
//  MonthVC.swift
//  Demo
//
//  Created by ELSAGA-MACOS on 9/16/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class MonthVC: UIViewController {

     var collectionViewFlowLayout : UICollectionViewFlowLayout!
    @IBOutlet weak var viewButton: UIView!
    @IBOutlet weak var btnMonth: UIButton!
    @IBOutlet weak var btnYear: UIButton!
    @IBOutlet weak var btnWeek: UIButton!
    @IBOutlet weak var btnDay: UIButton!
    @IBOutlet weak var lbMonth: UILabel!
    @IBOutlet weak var myCollection: UICollectionView!
    
    var allDaysInMonth : [Date] = [Date]()
    var data : [EventMonth] = [EventMonth]()
    var currentMonth : Int = 0
    var currentYear : Int = 0
    var currentDay : Int = 0
    var firstMonth  =  Date()
    var endOfWeek = Date()
    var endOfWeekDay : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        var calendar = Calendar.current
        currentMonth = calendar.component(.month, from: date)
        currentYear = calendar.component(.year, from: date)
        currentDay = calendar.component(.day, from: date)
        firstMonth = CalendarVC.dateFrom(year: currentYear, month: currentMonth, day: 1)
        endOfWeek = calendar.endOfWeek(firstMonth)
        endOfWeekDay = Int(endOfWeek.toString(dateFormat: "dd"))!
        
        myCollection.register(UINib.init(nibName: "CellMonth", bundle: nil), forCellWithReuseIdentifier: "CellMonth")
        allDaysInMonth = Utils.getAllDateOfMonth(month: currentMonth, year: currentYear)
        //lbMonth.text = "Tháng \(currentMonth) - \(currentYear)"
        data = GetData.loadJson()!
        conFig()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
           if gesture.direction == .right {
                if currentMonth == 1 {
                   let preMonth = 12
                   let preYear = currentYear - 1
                   allDaysInMonth = Utils.getAllDateOfMonth(month: preMonth, year: preYear)
                   myCollection.reloadData()
                   lbMonth.text = "Tháng \(preMonth) - \(preYear)"
                    currentMonth = preMonth
                    currentYear = preYear
               }
               else{
                   let preMonth = currentMonth - 1
                   let preYear = currentYear
                   allDaysInMonth = Utils.getAllDateOfMonth(month: preMonth, year: preYear)
                   myCollection.reloadData()
                   lbMonth.text = "Tháng \(preMonth) - \(preYear)"
                    currentMonth = preMonth
                    currentYear = preYear
               }
           }
           else if gesture.direction == .left {
            if currentMonth == 12 {
                let newMonth = 1
                let newYear = currentYear + 1
                allDaysInMonth = Utils.getAllDateOfMonth(month: newMonth, year: newYear)
                myCollection.reloadData()
                lbMonth.text = "Tháng \(newMonth) - \(newYear)"
                currentMonth = newMonth
                currentYear = newYear
            }
            else{
                let newMonth = currentMonth + 1
                let newYear = currentYear
                allDaysInMonth = Utils.getAllDateOfMonth(month: newMonth, year: newYear)
                myCollection.reloadData()
                lbMonth.text = "Tháng \(newMonth) - \(newYear)"
                currentMonth = newMonth
                currentYear = newYear
            }
           }
        }
        override func viewWillLayoutSubviews() {
                super.viewWillLayoutSubviews()
                setUpCollectionViewItems()
            }
            //MARK: funtion setup
        func conFig(){
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
            btnYear.backgroundColor = #colorLiteral(red: 0.279307127, green: 0.3288925588, blue: 0.3904538155, alpha: 1)
            btnMonth.backgroundColor = #colorLiteral(red: 0.1477420032, green: 0.232701242, blue: 0.3159016967, alpha: 1)
        }
        func setUpCollectionViewItems(){
            if collectionViewFlowLayout == nil{
                let width : CGFloat = 1009
                let height: CGFloat = 666
                let numberOfItemInRow : CGFloat = 7
                let numberOfRow : CGFloat = 6
                let iLineSpaing : CGFloat = 5
                let interItemSpacing : CGFloat = 2.5
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
        static func dateFrom(year: Int, month: Int, day: Int) -> Date {
            let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
            gregorianCalendar.timeZone = TimeZone(abbreviation: "GMT")!

            var dateComponents = DateComponents()
            dateComponents.year = year
            dateComponents.month = month
            dateComponents.day = day

            let date = gregorianCalendar.date(from: dateComponents)!
            return date
        }
        //MARK: Button
    
        @IBAction func btnChooseDay(_ sender: Any) {
            let dayVC = CalendarViewController.init()
            self.navigationController?.pushViewController(dayVC, animated: false)
        }
        @IBAction func btnChooseWeek(_ sender: Any) {
            let weekVC = WeekVC.init()
            self.navigationController?.pushViewController(weekVC, animated: false)
        }
        @IBAction func btnChooseYear(_ sender: Any) {
        }
        
        @IBAction func btnChooseMonth(_ sender: Any) {
            
        }
    }
    extension MonthVC : UICollectionViewDelegate, UICollectionViewDataSource{
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return allDaysInMonth.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            //var calendar = Calendar.current
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellMonth", for: indexPath) as! CellMonth
            let date = allDaysInMonth[indexPath.row] as Date
            
            let currentDate = Date()
            let event = GetData.findEvent(value: date, in: self.data)
            if event != nil {
                cell.lbEvent.text = event
            }
            else{
                cell.lbEvent.text = ""
            }

            if (currentDate.day == date.day && currentDate.month == date.month && currentDate.year == date.year){
                //cell.viewCell.backgroundColor = .red
            }
            else{
                //cell.viewCell.backgroundColor = .clear
            }

            cell.lbDay.text = date.toString(dateFormat: "dd")
            
            if (date.month == currentMonth){
                //thang hien tai
                cell.lbDay.textColor = .white
            }
            else{
                //thang truoc hoac hoac thang sau
                cell.lbDay.textColor = .gray
            }
            return cell
        }

}
