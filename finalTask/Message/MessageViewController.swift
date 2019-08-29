//
//  MessageViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/19.
//  Copyright © 2019 VERTEX20. All rights reserved.
//


import UIKit

// チャット用画面。クラスに追加
class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchTableView: UITableView!

    // 遷移先に渡す情報
    var messageData: String = ""

    // 名前データを格納した配列。
    var nameList: [String] = ["Yui Yoshizawa", "Yu Nagai", "Taisuke Nakmura", "Taiga Shiga", "Yuta Wannme", "Kiichi Fukuzawa", "Yuriko Tsunokuni", "Nana Hirata"
    ]
    // 画像データを入れた配列
    var images: [String] = ["enako1", "humburger", "bakedMeet", "doraemon", "sweets1", "tenkinoko", "カレー横長", "スープアイコン"]

    override func viewDidLoad() {
        super.viewDidLoad()

        searchTableView.delegate = self
        searchTableView.dataSource = self
    }

    // セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameList.count
    }

    // セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    // セルの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        // テキストの改行
        cell.textLabel?.numberOfLines = 0
        // テキストの表示
        cell.textLabel?.text = nameList[indexPath.row]
        cell.imageView?.image = UIImage(named: images[indexPath.row])

        return cell
    }
    // セルを選択されたときの処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セグエで画面遷移
        performSegue(withIdentifier: "messageSegue", sender: nil)
    }



}
