//
//  profileChangeViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/22.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ProfileChangeViewController: UIViewController {

    // アイコン画像
    @IBOutlet var iconImage: UIImageView!
    // 名前のテキストフィールド
    @IBOutlet var nameTextField: UITextField!
    // 年齢のテキストフィールド
    @IBOutlet var ageTextField: UITextField!
    // コメントのテキストフィールド
    @IBOutlet var commentTextField: UITextField!
    // 趣味のテキストフィールド
    @IBOutlet var hobbyTextField: UITextField!


    // firestoreをインスタンス化
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        // ナビゲーションバーを出す
        navigationController?.isNavigationBarHidden = false
        
    }

    // 変更ボタン。画面遷移する
    @IBAction func infoChangeButton(_ sender: Any) {
        // 場所を定数化
        let name = nameTextField.text
        // 年齢を定数化
        let age = ageTextField.text
        // コメントを定数化
        let comment = commentTextField.text
        // 趣味の定数化
        let hobby = hobbyTextField.text

        // Firestoreに飛ばす箱を用意
        let userData: NSDictionary = ["name": name ?? "", "age": age ?? "", "comment": comment ?? "", "hobby": hobby ?? ""]
        // ユーザーIDのオプショナルを外す
        guard let userId = Auth.auth().currentUser?.uid else { return }
        // コレクションとドキュメントを指定
        let users = db.collection("users").document("\(userId)")
        // データをアップデート
        users.updateData(userData as! [String : Any])

        // 画面を消す
        self.dismiss(animated: true)
    }

    // アイコンイメージを変えるボタン
    @IBAction func iconChangeButton(_ sender: Any) {

    }
    // バック画像を変更するボタン
    @IBAction func backImageChangeButton(_ sender: Any) {
    }
    

}
