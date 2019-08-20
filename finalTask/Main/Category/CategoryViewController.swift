//
//  CategoryViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/20.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

// 基本は縦スクロール。場所と食べ物の種類は横スクロール。UIScrollViewとUICollectionView で Facebook風

import UIKit

class CategoryViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var wigthScollView: UIScrollView!
    @IBOutlet weak var pageControll: UIPageControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        wigthScollView.contentSize = CGSize(width: wigthScollView.frame.size.width * 3,
                                        height: wigthScollView.frame.size.height)


        // Do any additional setup after loading the view.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControll.currentPage = Int(wigthScollView.contentOffset.x / wigthScollView.frame.size.width)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
