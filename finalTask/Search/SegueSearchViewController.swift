//
//  SegueSearchViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/23.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

import UIKit

class SegueSearchViewController: UIViewController {
    // テキストフィールド
    @IBOutlet weak var searchTextFiesld: UITextField!
    // 検索ボタン
    @IBOutlet weak var searchButton: UIButton!

    // テーブルビュー
    @IBOutlet weak var searchTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // 自動でキーボードを出す
        self.searchTextFiesld.becomeFirstResponder()
    }
}


