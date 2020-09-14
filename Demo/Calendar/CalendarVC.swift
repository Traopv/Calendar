//
//  CalendarVC.swift
//  Demo
//
//  Created by ELSAGA-MACOS on 9/11/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class CalendarVC: UIViewController {

    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    @IBOutlet weak var viewButton: UIView!
    @IBOutlet weak var btnDay: UIButton!
    @IBOutlet weak var btnMonth: UIButton!
    @IBOutlet weak var lbMonth: UILabel!
    @IBOutlet weak var viewCollection: UIView!
    @IBOutlet weak var myCollection: UICollectionView!
    
    var allDaysInMonth : [Date] = [Date]()
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
        
        myCollection.register(UINib.init(nibName: "CellCalendar", bundle: nil), forCellWithReuseIdentifier: "CellCalendar")
        allDaysInMonth = Utils.getAllDateOfMonth(month: currentMonth, year: currentYear)
        lbMonth.text = "Tháng \(currentMonth) - \(currentYear)"
        
        conFig()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)

        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        

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
       else if gesture.direction == .up {
            let newMonth = currentMonth
            let newYear = currentYear + 1
            allDaysInMonth = Utils.getAllDateOfMonth(month: newMonth, year: newYear)
            myCollection.reloadData()
            lbMonth.text = "Tháng \(newMonth) - \(newYear)"
            currentMonth = newMonth
            currentYear = newYear
       }
       else if gesture.direction == .down {
            let preMonth = currentMonth
            let preYear = currentYear - 1
            allDaysInMonth = Utils.getAllDateOfMonth(month: preMonth, year: preYear)
            myCollection.reloadData()
            lbMonth.text = "Tháng \(preMonth) - \(preYear)"
            currentMonth = preMonth
            currentYear = preYear
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
        btnMonth.layer.masksToBounds = true
    }
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
    @IBAction func btnCurrentDay(_ sender: Any) {
        let date = Date()
        allDaysInMonth = Utils.getAllDateOfMonth(month: date.month, year: date.year)
        lbMonth.text = "Tháng \(date.month) - \(date.year)"
        currentMonth = date.month
        currentYear = date.year
        currentDay = date.day
        myCollection.reloadData()
    }
    
    @IBAction func btnDay(_ sender: Any) {
        btnMonth.backgroundColor = #colorLiteral(red: 0.279307127, green: 0.3288925588, blue: 0.3904538155, alpha: 1)
        btnDay.backgroundColor = #colorLiteral(red: 0.1477420032, green: 0.232701242, blue: 0.3159016967, alpha: 1)
    }
    
    @IBAction func btnMonth(_ sender: Any) {
        btnDay.backgroundColor = #colorLiteral(red: 0.279307127, green: 0.3288925588, blue: 0.3904538155, alpha: 1)
        btnMonth.backgroundColor = #colorLiteral(red: 0.1477420032, green: 0.232701242, blue: 0.3159016967, alpha: 1)
    }
}
extension CalendarVC : UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allDaysInMonth.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //var calendar = Calendar.current
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCalendar", for: indexPath) as! CellCalendar
        let date = allDaysInMonth[indexPath.row] as Date
        
        let currentDate = Date()
        if (currentDate.day == date.day && currentDate.month == date.month && currentDate.year == date.year){
            cell.viewCell.backgroundColor = .red
        }
        else{
            cell.viewCell.backgroundColor = .clear
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
