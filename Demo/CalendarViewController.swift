//
//  CalendarViewController.swift
//  Demo
//
//  Created by ELSAGA-MACOS on 9/9/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    
    @IBOutlet weak var viewButton: UIView!
    @IBOutlet weak var btnDay: UIButton!
    @IBOutlet weak var btnMonth: UIButton!
    @IBOutlet weak var lbMonth: UILabel!
    @IBOutlet weak var myCollection: UICollectionView!
    
    
    var allDaysInMonth: [Date] = []
    let list: [String] = ["3", "0", "1", "2", "3", "0"]
    var listMont : [Int] = [10,11,12,9]
    
    var currentIndex: Int = 0
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
        myCollection.register(UINib.init(nibName: "CellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CellCollectionViewCell")
//        loadData(currentMonth, currentYear)
        lbMonth.text = "Tháng \(currentMonth) - \(currentYear)"
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpCollectionViewItems()
    }
    //MARK: funtion setup
    func setUpCollectionViewItems(){
        if collectionViewFlowLayout == nil{
            let numberOfItemInRow : CGFloat = 1
            let iLineSpaing : CGFloat = 0
            let interItemSpacing : CGFloat = 0
            let iWidth = myCollection.frame.size.width
//                (myCollection.frame.size.width - (numberOfItemInRow - 1) * interItemSpacing) / numberOfItemInRow
            let iHeight = myCollection.frame.size.height
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: iWidth, height: iHeight)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .horizontal
            collectionViewFlowLayout.minimumLineSpacing = iLineSpaing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            
            myCollection.setCollectionViewLayout(collectionViewFlowLayout, animated : true)
        }
    }

}
extension CalendarViewController : UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCollectionViewCell", for: indexPath) as! CellCollectionViewCell
        cell.month = currentMonth
        cell.year = currentYear
        cell.setUpCollectionViewItems()
        cell.loadData()
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
            print("index: 0")
            listMont[2] = listMont[3] - 1
            if listMont[2] < 1 {
                listMont[2] = 12
            }
            listMont[0] = listMont[3] + 1
            if listMont[0] > 12 {
                listMont[0] = 1
            }
            
            currentIndex = list.count - 2
            DispatchQueue.main.async {
                self.myCollection.scrollToItem(at: IndexPath(row: self.currentIndex, section: 0), at: .left, animated: false)
                self.currentMonth = self.listMont[3]
            }
        } else {
            var index: Int = Int(offsetX/scrollView.bounds.width)
            index = index >= list.count ? list.count - 1 : index
            
            var indexOfCont = Int(list[index])
            var nextindex  = indexOfCont! + 1
            
            listMont[nextindex % 4]  = listMont[indexOfCont!] + 1
            
            if listMont[nextindex % 4] > 12 {
                listMont[nextindex % 4] = 1
            }
            //gan tgang trc do
             var preindex  = indexOfCont! - 1
            if preindex < 0 {
                preindex = 3
            }
            
            listMont[preindex]  = listMont[indexOfCont!] - 1
            
            if listMont[preindex] < 1 {
                listMont[preindex] = 12
            }
            print("==> listMont[preindex]",listMont[preindex])
            if index == list.count - 1 {
                DispatchQueue.main.async {
                    self.currentIndex = 1
                    self.myCollection.scrollToItem(at: IndexPath(row: self.currentIndex, section: 0), at: .left, animated: false)
                    self.currentMonth = self.listMont[indexOfCont!]
                    
                }
            } else  {
                currentIndex = index
                self.currentMonth = self.listMont[indexOfCont!]
            }
        }
    }
}

extension Calendar{
    mutating func dayOfWeek(_ date: Date) -> Int {
        var dayOfWeek = self.component(.weekday, from: date) - self.firstWeekday
        self.timeZone = TimeZone(abbreviation: "GMT")!
        if dayOfWeek <= 0 {
            dayOfWeek += 7
        }

        return dayOfWeek
    }
    mutating func startOfWeek(_ date: Date) -> Date {
        return self.date(byAdding: DateComponents(day: -self.dayOfWeek(date) + 1), to: date)!
    }

    mutating func endOfWeek(_ date: Date) -> Date {
        return self.date(byAdding: DateComponents(day: 6), to: self.startOfWeek(date))!
    }
     func getAllDaysInMonth(_ month: Int, _ year : Int) -> Int{
        
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return numDays
    }
}

extension Date {
    func dayOfWeek() -> Int{
        let timeZone = TimeZone(abbreviation: "GMT")
        let component =  Calendar.current.dateComponents(in: timeZone!, from: self)
        return (component.weekday ?? -1) - 1
    }
    // ngày đầu tháng của tháng hiện tại
    func startOfMonth() -> Date {
        
        var components = Calendar.current.dateComponents([.year,.month], from: self)
        components.day = 2
        let firstDateOfMonth: Date = Calendar.current.date(from: components)!
        return firstDateOfMonth
    }
    // ngày cuối tháng của tháng hiện tại
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    // lấy ra ngày kế tiếp theo số ngày truyền vào của tháng hiện tại
    func nextDate(_ index : Int) -> Date {
        let nextDate = Calendar.current.date(byAdding: .day, value: index, to: self)
        return nextDate ?? Date()
    }
    // lấy ra ngày trước đó theo số ngày truyền vào của tháng hiện tại
    func previousDate(_ day: Int) -> Date {
        let previousDate = Calendar.current.date(byAdding: .day, value: -day, to: self)
        return previousDate ?? Date()
    }
    // lấy ra tháng kế tiếp theo số tháng truyền vào của tháng hiện tại
    func addMonths(numberOfMonths: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .month, value: numberOfMonths, to: self)
        return endDate ?? Date()
    }
    // lấy ra tháng các tháng trước theo số tháng truyền vào của tháng hiện tại
    func getPreviousMonths(numberOfMonths: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .month, value: -numberOfMonths, to: self)
        return endDate ?? Date()
    }
    // lấy ra năm trước
    var getPreviousYear: Date {
       return Calendar.current.date(byAdding: .year, value: -1, to: self)!
    }
    // lấy ra tháng kế tiếp
    var getNextMonthDate: Date {
       return Calendar.current.date(byAdding: .month, value: 1, to: self)!
    }
    // lấy ra tháng trước
    var getPreviousMonthDate: Date {
       return Calendar.current.date(byAdding: .month, value: -1, to: self)!
    }
    // ngày đầu tháng và cuối tháng của tháng kế tiếp
    var startDateOfNextMonth: Date {
       return getNextMonthDate.startOfMonth()
    }

    var endOfNextMonth: Date {
       return getNextMonthDate.endOfMonth()
    }

    // ngày đầu tháng và cuối tháng của tháng trước
    var startDateOfPreviousMonth: Date {
       return getPreviousMonthDate.startOfMonth()
    }

    var endOfPreviousMonth: Date {
       return getPreviousMonthDate.endOfMonth()
    }
    // create date from day,month,year
    
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
