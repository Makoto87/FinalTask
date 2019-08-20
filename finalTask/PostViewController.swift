//
//  PostViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/20.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

//    // アイコンのimageView
//    @IBOutlet weak var iconImageView: UIImageView!
//    // 場所のテキストフィールド
//    @IBOutlet weak var placeTextField: UITextField!
//    // 時間のテキストフィールド
//    @IBOutlet weak var timeTextField: UITextField!
//    // カテゴリーのテキストフィールド
//    @IBOutlet weak var categoryTextField: UITextField!
//    // 価格のテキストフィールド
//    @IBOutlet weak var priceTextField: UITextField!
//    // フリーコメントのテキストビュー
//    @IBOutlet weak var commentTextView: UITextView!
//    // 色を変えるために用意した投稿ボタンのoutlet
//    @IBOutlet weak var postAppearButton: UIButton!



    override func viewDidLoad() {
        super.viewDidLoad()
        // コメント欄の枠線設定
//        commentTextView.layer.borderWidth = 1.0
//        commentTextView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        commentTextView.layer.cornerRadius = 10.0
//
//        placeTextField.isEnabled = true


        // 入力判定するもの
//        NotificationCenter.default.addObserver(self, selector: #selector(PostViewController.changeNotifyTextField(sender:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)

    }

    // 入力判定するもの
    public func changeNotifyTextField (sender: NSNotification) {
        guard let placeTextField = sender.object as? UITextField else {
            return
        }
        if placeTextField.text != nil {
    //        postAppearButton.setTitleColor(UIColor.blue, for: .normal)
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // ボタンの色を変える処理
   //     postAppearButton.setTitleColor(UIColor.blue, for: .normal)
    }

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        // ボタンの色を変える処理
  //      postAppearButton.setTitleColor(UIColor.blue, for: .normal)
    }

    // 開いた瞬間キーボードが表示される
    override func viewWillAppear(_ animated: Bool) {
    //    timeTextField.becomeFirstResponder()
    }

//    // キャンセルボタン
//    @IBAction func canselButton(_ sender: Any) {
//        view.backgroundColor = .blue
//    }
//
//    // 投稿ボタン
//    @IBAction func postButton(_ sender: Any) {
//
//    }
//

    @IBAction func button(_ sender: Any) {
    view.backgroundColor = UIColor.yellow
    }




}

