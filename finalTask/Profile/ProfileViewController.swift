//
//  ProfileViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/19.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

import UIKit

// プロフィールのクラス
class ProfileViewController: UIViewController {
    // バック画像
    @IBOutlet weak var backImageView: UIImageView!
    // アイコン画像
    @IBOutlet weak var iconImageView: UIImageView!
    // 名前のラベル
    @IBOutlet weak var nameLabel: UILabel!
    // 年齢のラベル
    @IBOutlet weak var ageLabel: UILabel!
    // コメントのラベル
    @IBOutlet weak var commentLabel: UILabel!
    // 戻るボタン丸くするためのもの
    @IBOutlet weak var backButtonOutlet: UIButton!
    // 変更ボタン丸くするためのもの
    @IBOutlet weak var changeButtonOutlet: UIButton!



    // テーブルビュー紐付け
    @IBOutlet weak var profileTableview: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        // 試し。アイコンとバックの画像
        backImageView.image = #imageLiteral(resourceName: "カレー横長")
        iconImageView.image = #imageLiteral(resourceName: "ランチ アイコン")
        // 試し。名前と年齢とコメント書き込み
        nameLabel.text = "堀田 真"
        ageLabel.text = "22歳"
        commentLabel.text = "美味しいご飯食べに行きましょう〜"

        // テーブルビューの線の色
        profileTableview.separatorColor = .orange
        profileTableview.backgroundColor = #colorLiteral(red: 1, green: 0.9725007454, blue: 0.9326803989, alpha: 1)

        // 戻るボタン丸くする
        self.backButtonOutlet.layer.cornerRadius = 10
        self.backButtonOutlet.layer.masksToBounds = true
        // 変更ボタン丸くする
        self.changeButtonOutlet.layer.cornerRadius = 10
        self.changeButtonOutlet.layer.masksToBounds = true

    }

    // 戻るボタン
    @IBAction func backButton(_ sender: Any) {
    }
    // プロフィール変更ボタン
    @IBAction func changeProfileButton(_ sender: Any) {
    }


}
