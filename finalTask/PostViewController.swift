//
//  TestViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/20.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

import UIKit

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

    // キーボードとテキストフィールドをかぶらせないためのもの
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Notificationの発行
        self.configureObserver()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // ボタンを押せなくする
        postOutlet.isEnabled = false
        buttonEnabled()             // ボタンの機能を変えるメソッド
        textFieldDidBeginEditing(placeTextField)

        // キーボードとテキストフィールドがかぶらないようにするメソッド
        self.commentTextField.delegate = self
        self.postScrollView.delegate = self
    }

    // ボタンを青色にするメソッド
    func buttonEnabled() {
        // プライスフィールドが1文字以上になれば青色になる
        if placeTextField.text != "" {
            postOutlet.tintColor = .blue
            postOutlet.isEnabled = true
        } else {
            postOutlet.tintColor = .gray
            postOutlet.isEnabled = false
        }

    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        postOutlet.tintColor = .blue
        postOutlet.isEnabled = true
    }



    // キーボードとテキストフィールドをかぶらせないようにするもの
    //returnが押されたときに呼ばれる.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // Notificationを設定
    func configureObserver() {

        let notification = NotificationCenter.default

        notification.addObserver(
            self,
            selector: #selector(self.keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        notification.addObserver(
            self,
            selector: #selector(self.keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    // Notificationを削除
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }

    // キーボードが現れたときにviewをずらす
    @objc func keyboardWillShow(notification: Notification?) {
        let rect = (notification?.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: duration!) {
            self.view.transform = CGAffineTransform(translationX: 0, y: -(rect?.size.height)!)
        }
    }

    // キーボードが消えたときにviewを戻す
    @objc func keyboardWillHide(notification: Notification?) {
        let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!) {
            self.view.transform = CGAffineTransform.identity
        }
    }





    // キャンセルボタン
    @IBAction func cancelButton(_ sender: Any) {
    }

    // 投稿ボタン
    @IBAction func postButton(_ sender: Any) {
    }

    // キーボード以外をタッチすればなくなる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 場所。キーボードが開いていたら
        if (placeTextField.isFirstResponder) {
            // 閉じる
            placeTextField.resignFirstResponder()
        }
        // 日時
        if (timeTextField.isFirstResponder) {
            timeTextField.resignFirstResponder()
        }
        // ジャンル
        if (categoryTextField.isFirstResponder) {
            categoryTextField.resignFirstResponder()
        }
        // 価格
        if (priceTextField.isFirstResponder) {
            priceTextField.resignFirstResponder()
        }
        // コメント
        if (commentTextField.isFirstResponder) {
            commentTextField.resignFirstResponder()
        }
    }



}
