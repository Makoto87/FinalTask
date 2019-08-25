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
import FirebaseFirestore    // インポート


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
    // firestoreのインスタンス化
    let db = Firestore.firestore()
    // データベースから取ってくる情報をすべて格納
    var items = [NSDictionary]()
    // 引っ張って更新する処理
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        // tableviewの delegateとdatasourseを接続
        tableView.delegate = self
        tableView.dataSource = self

        // 投稿ボタン丸くする
        self.sendButtonOutlet.layer.cornerRadius = 30
        self.sendButtonOutlet.layer.masksToBounds = true

        // 通知画面を隠す
        self.tableView2.isHidden = true

        // refreshControllに文言を追加
        refreshControl.attributedTitle = NSAttributedString(string: "引っ張って更新")      // 更新時の文字
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)  // アクションの指定
        tableView.addSubview(refreshControl)            // tableViewに追加

        // データを取ってくるメソッド
        fetch()
    }




//    // 遷移させる関数
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "toDetailSegue", let svc = segue.destination as? ViewController  else{
//            return
//        }
//        // 遷移先のreceiveDataに情報を移動させる
//        svc.receiveData1 = nameData
//        svc.receiveData2 = hobbyData
//
//    }

    // 引っ張って更新する処理のメソッド
    @objc func refresh() {
        // 初期化
        items = [NSDictionary]()
        // データをサーバから取得
        fetch()
        // リロード
        tableView.reloadData()
        // リフレッシュを止める
        refreshControl.endRefreshing()
    }

    // firestoreからデータの取得
    func fetch() {
        db.collection("post").getDocuments() {(querysnapshot, err) in

            var tempItems = [NSDictionary]()
            // アイテムを全部取ってくる。
            for item in querysnapshot!.documents {
                let dict = item.data()
                tempItems.append(dict as NSDictionary)      // tempItemsに追加
            }
            self.items = tempItems                          // 最初に作った配列に格納
            // 順番を入れ替え
            self.items = self.items.reversed()
            // リロード
            self.tableView.reloadData()
        }
    }


    // セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    // セルの高さを動的にする
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension //自動設定
    }

    // セルの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // itemsの中からindexpathのrow番目を取得
        let dict = items[(indexPath as NSIndexPath).row]

//        // 投稿画像がなかったらなくす
//        let postImageView = cell.viewWithTag(6) as! UIImageView
//        postImageView.isHidden = true
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
        placeLabel.text = dict["placeName"] as? String
        // 日時の表示
        let timeLabel = cell.viewWithTag(4) as! UILabel
        timeLabel.text = dict["wishTime"] as? String
        // コメントの表示
        let commentLabel = cell.viewWithTag(5) as! UILabel
        commentLabel.text = dict["wishComment"] as? String
//        //contentsのサイズに合わせてobujectのサイズを変える
//        commentLabel.sizeToFit()
        //単語の途中で改行されないようにする
//        commentLabel.lineBreakMode = NSLineBreakByWordWrapping

        

        return cell
    }

    // セルの遷移設定
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セグエで画面遷移。投稿の詳細を見る画面へ
        performSegue(withIdentifier: "toDetailSegue", sender: items[(indexPath as NSIndexPath).row])
    }

    // 投稿ボタン。画面遷移する
    @IBAction func sendButton(_ sender: Any) {
        performSegue(withIdentifier: "sendPost", sender: nil)
    }

    // いいねボタン
    @IBAction func goodButton(_ sender: UIButton) {
        // 選択されたボタンの座標位置を取得
        let point = self.tableView.convert(sender.center, from: sender)
        // Tableviewの座標へ変換して該当のindexPathを取得
        guard let indexPath = self.tableView.indexPathForRow(at: point) else {
            print("ボタン情報の取得失敗")
            return
        }
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PostCellViewController
        vc.items = [sender as! NSDictionary]
    }

    

}

