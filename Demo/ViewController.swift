//
//  ViewController.swift
//  Demo
//
//  Created by Macintosh on 9/8/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colView: UICollectionView!
    let list: [String] = ["3", "0", "1", "2", "3", "0"]
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainCollectionViewCell
        cell.lblCount.text = list[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

extension ViewController: UICollectionViewDelegate, UIScrollViewDelegate {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("scrollViewDidEndScrollingAnimation")
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = colView.contentOffset.x
        if offsetX < scrollView.bounds.width {
            print("index: 0")
            currentIndex = list.count - 2
            DispatchQueue.main.async {
                self.colView.scrollToItem(at: IndexPath(row: self.currentIndex, section: 0), at: .left, animated: false)
            }
        } else {
            var index: Int = Int(offsetX/scrollView.bounds.width)
            index = index >= list.count ? list.count - 1 : index
            print("index \(index)")

            if index == list.count - 1 {
                DispatchQueue.main.async {
                    self.currentIndex = 1
                    self.colView.scrollToItem(at: IndexPath(row: self.currentIndex, section: 0), at: .left, animated: false)
                }
            } else  {
                currentIndex = index
            }
        }
    }
}
