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
import FirebaseAuth


// テーブルビューとサイドメニューのクラスを追加
class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // テーブルビュー。タグ付けしている
    // 1 アイコン・2 名前・3 場所・4 日時・5 コメント・6 写真
    @IBOutlet weak var tableView: UITableView!
    // 通知用テーブルビュー
    @IBOutlet weak var alertTableView: UITableView!
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
    // 投稿のデータベースから取ってくる情報をすべて格納
    var items = [NSDictionary]()
    // 引っ張って更新する処理
    let refreshControl = UIRefreshControl()
    // いいねの更新する処理
    let likeRefreshControl = UIRefreshControl()
    // いいねした人の情報を入れるためのメソッド。
    var likeItems: [NSDictionary] = []
    // 自分の名前を入れる変数
    var name = ""
    // テスト用画像配列
    let testImage = ["splashRogoRemake", "taki_rentarod", "doraemon", "enako1", "tenkinoko", "ランチ アイコン", "icon1", "icon", "icon2"]
    // 名前データを格納した配列。
    var nameList: [String] = ["Yui Yoshizawa", "Yu Nagai", "Taisuke Nakmura", "Taiga Shiga", "Yuta Wannme", "Kiichi Fukuzawa", "Yuriko Tsunokuni", "Nana Hirata", "Shotaro Tauchi", "Masahiro Toyooka", "Yusuke Ono", "Kaori Kaizaki", "Yusaku Kanada", "Makoto Horita"
    ]


    override func viewDidLoad() {
        super.viewDidLoad()

        // tableviewの delegateとdatasourseを接続
        tableView.delegate = self
        tableView.dataSource = self
        alertTableView.delegate = self
        alertTableView.dataSource = self

        // セルのファイルを使うためのもの
        tableView.register(AlertTableViewCell.self, forCellReuseIdentifier: "alertCell")

        // 投稿ボタン丸くする
        self.sendButtonOutlet.layer.cornerRadius = 30
        self.sendButtonOutlet.layer.masksToBounds = true

        // 通知画面を隠す
        self.alertTableView.isHidden = true

        // refreshControllに文言を追加
        refreshControl.attributedTitle = NSAttributedString(string: "引っ張って更新")
        likeRefreshControl.attributedTitle = NSAttributedString(string: "引っ張って更新")// 更新時の文字
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)  // アクションの指定
        likeRefreshControl.addTarget(self, action: #selector(likeRefresh), for: .valueChanged)  // いいね一覧のテーブルビューに表示
        tableView.addSubview(refreshControl)            // tableViewに追加
        alertTableView.addSubview(likeRefreshControl)       // 通知画面に追加

        // データを取ってくるメソッド
        fetch()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailSegue" {
        let vc = segue.destination as! PostCellViewController
        vc.items = [sender as! NSDictionary]
//        } else if segue.identifier == "toDetailAlert" {
//            let vc = segue.destination as! DetailAlertViewController
        } else {
            return
        }
    }

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

    @objc func likeRefresh() {
        likeItems = [NSDictionary]()
        likeFetch()
        alertTableView.reloadData()
        likeRefreshControl.endRefreshing()
    }

    // firestoreからデータの取得
    func likeFetch() {
        
        // 取得データを格納する場所。辞書型
        var tempItems: [NSDictionary] = []
        // 取得したドキュメントを入れる
        var dict = [String: Any]()
        // likesコレクションからドキュメントを取る
        db.collection("likes").getDocuments() {(querysnapshot, err) in
            // 全てのドキュメント内データを各々dictに入れて処理する
            for item in querysnapshot!.documents {
                dict = item.data()
                // ユーザーIDのオプショナルを外す
                guard let userId = Auth.auth().currentUser?.uid else { return }
                // 自分のIDと取ったIDが同じ場合
                if userId == dict["likedUser"] as? String {
                        // IDが一致した辞書型を配列に組み込む
                        tempItems.append(dict as NSDictionary)
                }
            }

            // 用意していたlikeItemsに特定の辞書型だけを入れる
            self.likeItems = tempItems
            // 順番を入れ替え
            self.likeItems = self.likeItems.reversed()
            // リロード
            self.alertTableView.reloadData()
        }
    }

    // firestoreから投稿データを取得
    func fetch() {
        // 取得データを格納する場所
        var tempItems = [NSDictionary]()
        // postドキュメントからデータをもらう
        db.collection("post").getDocuments() {(querysnapshot, err) in
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

    // 自分のyプロフィール情報を取得
    func getUserItem() {
        // 取得データを格納する
        var tempItems = [NSDictionary]()
        // usersドキュメントからデータをもらう
        db.collection("users").getDocuments() {(querysnapshot, err) in
            // アイテムを全部取ってくる。
            for item in querysnapshot!.documents {
                // ユーザーIDのオプショナルを外す
                guard let userId = Auth.auth().currentUser?.uid else { return }
                // 自分のIDとドキュメントに入れたID名が同じ場合
                if userId == item["userID"] as? String {
                    // IDが一致した辞書型を配列に組み込む
                    tempItems.append(item.data() as NSDictionary)
                }
            }

            //                self.userItems = tempItems                          // 最初に作った配列に格納
            if let item = tempItems.first {
                self.name =
                    item["name"] as? String ?? ""
            } else {
                self.name = "匿名"
            }
        }
    }

    // セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 通知画面がないとき
        if self.alertTableView.isHidden == true{
            return items.count
        // 通知画面が表示されているとき
        } else {
            return likeItems.count
        }
    }

    // セルの高さを動的にする
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension //自動設定
    }

    // セルの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 通知画面が表示されていないとき
        if self.alertTableView.isHidden == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            // itemsの中からindexpathのrow番目を取得
            let dict = items[(indexPath as NSIndexPath).row]

//        // 投稿画像がなかったらなくす
//        let postImageView = cell.viewWithTag(6) as! UIImageView
//        postImageView.isHidden = true
            // アイコンを表示するところ
            let profileImageView = cell.viewWithTag(1) as! UIImageView
//            profileImageView.image = #imageLiteral(resourceName: "splashRogoRemake")
            // 完成しませんでした
            profileImageView.image = UIImage(named: testImage[indexPath.row])
            // アイコンを丸くする
            profileImageView.layer.cornerRadius = 30
            profileImageView.layer.masksToBounds = true
            // 名前の表示
            let nameLabel = cell.viewWithTag(2) as! UILabel
            nameLabel.text = dict["name"] as? String
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

        // 通知画面が表示されているとき
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "alertCell", for: indexPath) as! AlertTableViewCell
//            // itemsの中からindexpathのrow番目のドキュメントデータを取得
//            let dict = likeItems[(indexPath as NSIndexPath).row]

            cell.set(nameList: nameList, num: indexPath.row)
            // いいねした人の表示
//            cell.textLabel?.text = dict["likeUser"] as? String

            return cell
        }
    }

    // セルの遷移設定
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if alertBool == true {
        // セグエで画面遷移。投稿の詳細を見る画面へ
        performSegue(withIdentifier: "toDetailSegue", sender: items[(indexPath as NSIndexPath).row])
        } else {
            performSegue(withIdentifier: "toDetailAlert", sender: items[(indexPath as NSIndexPath).row])
        }
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
            // キー値と対応したドキュメントIDを取ってくる
            guard let userId = Auth.auth().currentUser?.uid else {
                    print("ログイン情報取得失敗")
                    return
            }
            // セルに対応した相手のIDを定数化
            let id = items[(indexPath as NSIndexPath).row]["userId"]
            // 相手のidのオプショナルを外す
            guard let partnerId = id else {return}
            // コレクションとドキュメントを指定
            let likes = db.collection("likes").document("\(userId)" + "\(partnerId)")
            // ドキュメントにいいねした人とされた人を入れる
            let ids: NSDictionary = ["likedUser": partnerId, "likeUser": userId, "name": name]
            // 作ったドキュメントにいいねした人を追加
            likes.setData(ids as! [String : Any])

        } else {
            sender.setTitleColor(UIColor.black, for: .normal)       // 黒色になる
            goodBool = true    // いいねがない状態に変わる
        }
    }

    // メッセージボタン
    @IBAction func sendMessageButtun(_ sender: Any) {
        print("未定&未完成です")
    }
    // 通知ボタン
    @IBAction func alertButton(_ sender: Any) {
        // まだ通知画面が出ていなかったとき
        if alertBool == true {
        // ボタンを押した瞬間tableViewが表れる
        self.alertTableView.isHidden = false
            // 通知画面出したという証拠
            alertBool = false
            // いいねリストを取ってくるメソッド
            likeFetch()
        // 通知画面が出ているとき
        } else {
            // tableViewを消す
            self.alertTableView.isHidden = true
            // 通知画面消したという証拠
            alertBool = true
        }
    }
}

