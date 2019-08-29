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

    // タイムラインへ遷移するメソッド。
    func toTimeLine(){
        // storyboardのfileの特定
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // 移動先のncをインスタンス化。ナビゲーションバーを表示させるために無理やり作ってる
        let nc = storyboard.instantiateInitialViewController() as! UITabBarController
        // 画面遷移のアニメーション追加
        nc.modalTransitionStyle = .crossDissolve
        self.present(nc, animated: true)
    }

    @IBAction func searchButtonAction(_ sender: Any) {
        toTimeLine()
    }
}
