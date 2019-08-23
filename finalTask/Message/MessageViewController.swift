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

// チャット用画面
class MessageViewController: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()


    }

//    // セルの数
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 30
//    }
//
//    // セルの設定
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
//
//
//
//        return cell
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
