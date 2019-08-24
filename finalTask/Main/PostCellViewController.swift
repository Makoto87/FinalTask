//
//  PostCellViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/21.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

import UIKit

class PostCellViewController: UIViewController {
    // アイコンの写真image
    @IBOutlet weak var iconImageView: UIImageView!
    // 名前のラベル
    @IBOutlet weak var nameLabel: UILabel!
    // 場所のラベル
    @IBOutlet weak var placeLabel: UILabel!
    // 日時のラベル
    @IBOutlet weak var timeLabel: UILabel!
    // ジャンルのラベル
    @IBOutlet weak var categoryLabel: UILabel!
    // 値段のラベル
    @IBOutlet weak var priceLabel: UILabel!
    // コメントラベル
    @IBOutlet weak var commentLabel: UILabel!
    // 写真載せるところ
    @IBOutlet weak var foodImageView: UIImageView!

    var goodBool: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        foodImageView.isHidden = true

    }

    // いいねボタン
    @IBAction func goodButton(_ sender: UIButton) {
        // いいねがついていなかったら
        if goodBool == true { sender.setTitleColor(UIColor.magenta, for: .normal)       // ピンク色になる
            goodBool = false    // いいねがついた状態を表す
        } else {
            sender.setTitleColor(UIColor.black, for: .normal)       // 黒色になる
            goodBool = true    // いいねがない状態に変わる
        }
    }
    // メッセージボタン
    @IBAction func messageButton(_ sender: UIButton) {
        print("まだ決まっていない")
    }
    

}
