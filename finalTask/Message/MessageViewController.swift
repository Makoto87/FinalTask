//
//  MessageViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/19.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

// JSQMessagesViewController    をチャット機能として使う
// UITableViewCellを追加していくことでタイムライン表示している。
// 表示する文字数によってはTableViewCellに配置しているUILabelが複数行表示になるため、cellForRowAtのタイミングでTableViewCellに計算済みのCellの高さを設定する。
// タップルみたいに「マッチした人とメッセージを贈り合ってみよう」と表示する


import UIKit
//import JSQMessagesViewController

// チャット用画面。クラスに追加
class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchTableView: UITableView!

    // 遷移先に渡す情報
    var messageData: String = ""

    // 名前データを格納した配列。
    var nameList: [String] = ["Yui Yoshizawa", "Yu Nagai", "Taisuke Nakmura", "Taiga Shiga", "Yuta Wannme", "Kiichi Fukuzawa", "Yuriko Tsunokuni", "Nana Hirata", "Shotaro Tauchi", "Masahiro Toyooka", "Yusuke Ono", "Kaori Kaizaki", "Yusaku Kanada", "Makoto Horita",

                              ]

    override func viewDidLoad() {
        super.viewDidLoad()

        searchTableView.delegate = self
        searchTableView.dataSource = self
    }

    // セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameList.count
    }

    // セルの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        // テキストの表示
        cell.textLabel?.text = nameList[indexPath.row]


        return cell
    }
    // セルを選択されたときの処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // タップされたセルの情報をデータに代入
//        messageData = nameList[indexPath.row]


        // セグエで画面遷移
        performSegue(withIdentifier: "messageSegue", sender: nil)
    }



}
