//
//  TestViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/20.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

import UIKit
import FirebaseFirestore        // インポート

class PostViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {

    // アイコンを表示するイメージビュー
    @IBOutlet weak var iconImageView: UIImageView!
    // 場所を書くテキストフィールド
    @IBOutlet weak var placeTextField: UITextField!
    // 日時を書くテキストフィールド
    @IBOutlet weak var timeTextField: UITextField!
    // ジャンルを書くテキストフィールド
    @IBOutlet weak var categoryTextField: UITextField!
    // 価格を書くテキストフィールド
    @IBOutlet weak var priceTextField: UITextField!
    // コメントを書くテキストフィールド
    @IBOutlet weak var commentTextField: UITextField!
    // 投稿ボタンの色を変えるためのoutlet
    @IBOutlet weak var postOutlet: UIButton!
    // キーボードを表示させる
    @IBOutlet weak var postScrollView: UIScrollView!

    // firestoreをインスタンス化
    let db = Firestore.firestore()

    // テキストフィールドに書かれたら反応する
    @IBAction func placeTextFieldAction(_ sender: UITextField) {
        // テキストに文字が入れられたとき
        if sender.text != ""{
            self.postOutlet.setTitleColor(UIColor.blue, for: .normal)       // 青色になる
            postOutlet.isEnabled = true                                     // ボタン使用可になる
        } else {
            self.postOutlet.setTitleColor(UIColor.gray, for: .normal)       // 灰色になる
            postOutlet.isEnabled = false                                    // ボタン使用不可になる
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // ボタンを押せなくする
        postOutlet.isEnabled = false
    }

    // キャンセルボタン
    @IBAction func cancelButton(_ sender: Any) {
    }

    // 投稿ボタン
    @IBAction func postButton(_ sender: Any) {
        // 場所を定数化
        let placeName = placeTextField.text
        // 日時を定数化
        let wishTime = timeTextField.text
        // ジャンルを定数化
        let wishCategory = categoryTextField.text
        // 価格の定数化
        let wishPrice = priceTextField.text
        // コメントの定数化
        let wishComment = commentTextField.text
        // Firestoreに飛ばす箱を用意
        let post: NSDictionary = ["placeName": placeName ?? "", "wishTime": wishTime ?? "", "wishCategory": wishCategory ?? "", "wishPrice": wishPrice ?? "", "wishComment": wishComment ?? ""]

        // userを辞書型へpost。
        // 辞書型でAnyを使っているのは、受け取るほうが何を受け取るかわからないから。firebaseが指定している。
        db.collection("post").addDocument(data: post as! [String : Any])

        // 画面を消す
        self.dismiss(animated: true)
    }

}
