//
//  DetailViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/24.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

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

    // firestoreのインスタンス化
    let db = Firestore.firestore()
    // 遷移前の特定の情報を格納
    var dItems = [NSDictionary]()

    // 画面遷移前からもらう情報を入れる
    var tag = 0
    var dict = [NSDictionary]()
    var items = [String: Any]()

    // いいねがついているか判断するもの
    var goodBool: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // 情報を持ってくる
        fetch()

    }

    // firestoreから投稿データを取得
    func fetch() {
        // 取得データを格納する場所
        var tempItems = [NSDictionary]()
        // postドキュメントからデータをもらう
        db.collection("post").getDocuments() {(querysnapshot, err) in
            // アイテムを全部取ってくる。
            for item in querysnapshot!.documents {
                let dic = item.data()
                // タグ情報と場所の値が同じときに配列へ追加
                if self.tag == dic["placeNumber"] as! Int {
                    tempItems.append(dic as NSDictionary)      // tempItemsに追加
                }

            }
            guard let detailitems = tempItems.first else { return }
            // 名前
            self.nameLabel.text = detailitems["name"] as? String
            // 場所
            self.placeLabel.text = detailitems["placeName"] as? String
            //年齢
            self.ageLabel.text = detailitems["age"] as? String
            // 日時
            self.timeLabel.text = detailitems["wishTime"] as? String
            // ジャンル
            self.categoryLabel.text = detailitems["wishCategory"] as? String
            // 値段
            self.priceLabel.text = detailitems["wishPrice"] as? String
            // コメント
            self.commentLabel.text = detailitems["wishComment"] as? String
            // 趣味
            self.hobbyLabel.text = detailitems["hobby"] as? String
            // 写真
        }


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
