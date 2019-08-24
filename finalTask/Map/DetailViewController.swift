//
//  DetailViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/24.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    // アイコンのイメージビュー
    @IBOutlet var iconImageView: UIImageView!
    // 名前のラベル
    @IBOutlet var nameLabel: UILabel!
    // 場所のラベル
    @IBOutlet var placeLabel: UILabel!
    // 年齢のラベル
    @IBOutlet var ageLabel: UILabel!
    // 日時のラベル
    @IBOutlet var timeLabel: UILabel!
    // ジャンルのラベル
    @IBOutlet var categoryLabel: UILabel!
    // 値段のラベル
    @IBOutlet var priceLabel: UILabel!
    // コメントのラベル
    @IBOutlet var commentLabel: UILabel!
    // 趣味のラベル
    @IBOutlet var hobbyLabel: UILabel!
    // 写真のイメージビュー
    @IBOutlet var photoImageView: UIImageView!

    // いいねがついているか判断するもの
    var goodBool: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func goodButton(_ sender: UIButton) {
        // いいねがついていなかったら
        if goodBool == true { sender.setTitleColor(UIColor.magenta, for: .normal)       // ピンク色になる
            goodBool = false    // いいねがついた状態を表す
        } else {
            sender.setTitleColor(UIColor.black, for: .normal)       // 黒色になる
            goodBool = true    // いいねがない状態に変わる
        }

    }

    // 返信ボタン
    @IBAction func messageButton(_ sender: Any) {
        print("まだ決まっていない")
    }

    // 戻るボタン
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }

    

}
