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
    @IBOutlet weak var lbEvent: UILabel!
    @IBOutlet weak var lbDayShow: UILabel!
    @IBOutlet weak var btnWeek: UIButton!
    @IBOutlet weak var btnYear: UIButton!
    
    
    var allDaysInMonth: [Date] = []
    var data : [EventDay] = [EventDay]()
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
        
        lbDayShow.text = ""
        
        data = GetData.loadJson1()!
        myCollection.register(UINib.init(nibName: "CellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CellCollectionViewCell")
        conFig()
        lbMonth.text = "Tháng \(currentMonth) - \(currentYear)"
        self.navigationController?.isNavigationBarHidden = true
        
        let data1 = GetData.loadJson1()
        let arr1 = GetData.findEvent1(value: date, in: data)
        print("==> arr1",arr1)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpCollectionViewItems()
    }
    
    //MARK:-
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
        btnMonth.backgroundColor = #colorLiteral(red: 0.279307127, green: 0.3288925588, blue: 0.3904538155, alpha: 1)
        btnWeek.backgroundColor = #colorLiteral(red: 0.279307127, green: 0.3288925588, blue: 0.3904538155, alpha: 1)
        btnYear.backgroundColor = #colorLiteral(red: 0.279307127, green: 0.3288925588, blue: 0.3904538155, alpha: 1)
        btnDay.backgroundColor = #colorLiteral(red: 0.1477420032, green: 0.232701242, blue: 0.3159016967, alpha: 1)
    }
    
    func setUpCollectionViewItems(){
        if collectionViewFlowLayout == nil{
            let iLineSpaing : CGFloat = 0
            let interItemSpacing : CGFloat = 0
            let iWidth = myCollection.frame.size.width
            let iHeight = myCollection.frame.size.height

            collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: iWidth, height: iHeight)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .horizontal
            collectionViewFlowLayout.minimumLineSpacing = iLineSpaing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing

            myCollection.setCollectionViewLayout(collectionViewFlowLayout, animated : true)
            myCollection.setContentOffset(CGPoint(x: myCollection.bounds.width, y: 0), animated: false)
        }
    }
    
    func reloadMonthTitle() {
        lbMonth.text = "Tháng \(currentPage.month) - \(currentPage.year)"
    }
    
    //MARK:-
    //MARK: Button function
    
    @IBAction func btnCurrentDay(_ sender: Any) {
    }
    
    @IBAction func btnChooseDay(_ sender: Any) {
    }
    
    @IBAction func btnChooseWeek(_ sender: Any) {
        let weekVC = WeekVC.init()
        self.navigationController?.pushViewController(weekVC, animated: false)
    }
    
    @IBAction func btnChooseYear(_ sender: Any) {
        let yearVC = YearVC.init()
        self.navigationController?.pushViewController(yearVC, animated: false)
    }
    
    @IBAction func btnChooseMonth(_ sender: Any) {
        let monthVC = MonthViewController.init()
        self.navigationController?.pushViewController(monthVC, animated: false)
    }
}

//MARK:-
extension CalendarViewController : UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMonth.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCollectionViewCell", for: indexPath) as! CellCollectionViewCell
        let date    = listMonth[indexPath.row]
        cell.month  = date.month
        cell.year   = date.year
        cell.setUpCollectionViewItems()
        cell.loadData()
        cell.closureShowEvent = { (dateChoose: Date) in
            self.lbDayShow.text = String(dateChoose.toString(dateFormat: "dd-MM-yyy"))
            let event = GetData.findEvent1(value: dateChoose, in: self.data)
            if event != nil {
                
                self.lbEvent.text = String(event![0].activiti)
            } else {
                self.lbEvent.text = "Không có sự kiện!"
            }
        }
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
                    strongSelf.myCollection.scrollToItem(at: IndexPath(row: strongSelf.currentIndex, section: 0), at: .left, animated: false)
                    strongSelf.reloadMonthTitle()
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
                        strongSelf.reloadMonthTitle()
                    }
                }
            } else {
                currentIndex = index
                reloadMonthTitle()
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
