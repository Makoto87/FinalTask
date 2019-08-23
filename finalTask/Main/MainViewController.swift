//
//  ViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/18.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

// 起動画面(スプラッシュ)
// ストーリーボード・・・タイムライン、地図、メッセージ、プロフィール、検索、
// view・・・プロフィール(ツイッター)、通知、投稿
// ボタン押すときのエフェクト https://github.com/okmr-d/DOFavoriteButton
// タブバー  https://github.com/Cuberto/flashy-tabbar
// ナビゲーションバー https://qiita.com/homyu/items/1365c8f8c3be4465df87
// ナビとタブバー https://qiita.com/yamatatsu10969/items/b737f21fa162c998fd36
// テーブルビュー2つ使う場合  https://qiita.com/naoto_mitsuya/items/62b5c36aafbc0f256c48

import UIKit
import Material     // マテリアルをインポート


// テーブルビューとサイドメニューのクラスを追加
class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // テーブルビュー。タグ付けしている
    // 1 アイコン・2 名前・3 場所・4 日時・5 コメント・6 写真
    @IBOutlet weak var tableView: UITableView!
    // 通知用テーブルビュー
    @IBOutlet weak var tableView2: UITableView!

    // 投稿ボタンのoutolet
    @IBOutlet weak var sendButtonOutlet: UIButton!
    // タブバーの画像を紐付け
    @IBOutlet weak var timelineImage: UITabBarItem!
    // いいねがついているか判断するもの
    var goodBool: Bool = true
    // 通知画面が表示されているか判断するもの
    var alertBool: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

//         tableviewの delegateとdatasourseを接続
        tableView.delegate = self
        tableView.dataSource = self

//        self.view = tableView

        // 投稿ボタン丸くする
        self.sendButtonOutlet.layer.cornerRadius = 30
        self.sendButtonOutlet.layer.masksToBounds = true

        // 通知画面を隠す
        self.tableView2.isHidden = true

    }

    // セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    // セルの高さを動的にする
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension //自動設定
    }

    // セルの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // 投稿画像がなかったらなくす
        let postImageView = cell.viewWithTag(6) as! UIImageView
        postImageView.isHidden = true
        // アイコンを表示するところ
        let profileImageView = cell.viewWithTag(1) as! UIImageView
        profileImageView.image = #imageLiteral(resourceName: "splashRogoRemake")
        // アイコンを丸くする
        profileImageView.layer.cornerRadius = 30
        profileImageView.layer.masksToBounds = true
        // 名前の表示
        let nameLabel = cell.viewWithTag(2) as! UILabel
        nameLabel.text = "堀田 真"
        // 場所の表示
        let placeLabel = cell.viewWithTag(3) as! UILabel
        placeLabel.text = "新宿"
        // 日時の表示
        let categoryLabel = cell.viewWithTag(4) as! UILabel
        categoryLabel.text = "今夜"
        // コメントの表示
        let commentLabel = cell.viewWithTag(5) as! UILabel
        commentLabel.text = "授業後にガッツリ食べたいです!"
        

        return cell
    }

    // セルの遷移設定
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セグエで画面遷移。投稿の詳細を見る画面へ
        performSegue(withIdentifier: "toDetailSegue", sender: nil)
    }

    // 投稿ボタン。画面遷移する
    @IBAction func sendButton(_ sender: Any) {
        performSegue(withIdentifier: "sendPost", sender: nil)
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
    @IBAction func sendMessageButtun(_ sender: Any) {
    }
    // 通知ボタン
    @IBAction func alertButton(_ sender: Any) {
        // まだ通知画面が出ていなかったとき
        if alertBool == true {
        // ボタンを押した瞬間tableViewが表れる
        self.tableView2.isHidden = false
            // 通知画面出したという証拠
            alertBool = false
        // 通知画面が出ているとき
        } else {
            // tableViewを消す
            self.tableView2.isHidden = true
            // 通知画面消したという証拠
            alertBool = true

        }
    }


}

