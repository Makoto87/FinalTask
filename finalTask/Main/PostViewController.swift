//
//  TestViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/20.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

import UIKit
import FirebaseFirestore        // インポート
import FirebaseAuth

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
    // 名前を表示する
    @IBOutlet var nameLabel: UILabel!


    // firestoreをインスタンス化
    let db = Firestore.firestore()
    // データベースのプロフ情報から名前のデータを抜き取る
    var name = ""

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
        // 自動でキーボードを表示する
        self.placeTextField.becomeFirstResponder()
        // ボタンを押せなくする
        postOutlet.isEnabled = false
        // テスト。アイコンを載せる
        iconImageView.image = #imageLiteral(resourceName: "doraemon")
        // 名前の情報だけを取ってくる
        fetch()
    }

    // データベースからプロフ情報を持ってくる
    func fetch() {
        // usersドキュメントからデータをもらう
        db.collection("users").getDocuments() {(querysnapshot, err) in
            // アイテムを全部取ってくる。
            for item in querysnapshot!.documents {
                let dict = item.data()
                // ユーザーIDのオプショナルを外す
                guard let userId = Auth.auth().currentUser?.uid else { return }
                // 自分のIDと取ったIDが同じ場合
                if userId == dict["userID"] as? String {
                    // 名前の情報を取る
                    self.name = dict["name"] as? String ?? ""
                    self.nameLabel.text = dict["name"] as? String ?? ""
                }
            }
        }
    }

    // キャンセルボタン
    @IBAction func cancelButton(_ sender: Any) {
    }

    // 投稿ボタン
    @IBAction func postButton(_ sender: Any) {
        // 場所を定数化
        let placeName = placeTextField.text
        // マップのときに使う数字
        var placeNumber = 0
        // 日時を定数化
        let wishTime = timeTextField.text
        // ジャンルを定数化
        let wishCategory = categoryTextField.text
        // 価格の定数化
        let wishPrice = priceTextField.text
        // コメントの定数化
        let wishComment = commentTextField.text

        switch placeName {
        case "大阪":
            placeNumber = 0
        case "新宿":
            placeNumber = 1
        case "渋谷":
            placeNumber = 2
        case "池袋":
            placeNumber = 3
        case "六本木":
            placeNumber = 4
        case "東京駅":
            placeNumber = 5
        case "品川":
            placeNumber = 6
        default:
            return
        }

        // ログインしているユーザーのIDを使う
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        // Firestoreに飛ばす箱を用意
        let post: NSDictionary = ["placeName": placeName ?? "", "placeNumber": placeNumber, "wishTime": wishTime ?? "", "wishCategory": wishCategory ?? "", "wishPrice": wishPrice ?? "", "wishComment": wishComment ?? "", "userId": userId, "name": name]

        // userを辞書型へpost。
        // 辞書型でAnyを使っているのは、受け取るほうが何を受け取るかわからないから。firebaseが指定している。
        db.collection("post").addDocument(data: post as! [String : Any])

        // 画面を消す
        self.dismiss(animated: true)
    }

}
