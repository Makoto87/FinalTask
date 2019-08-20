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


import UIKit
import JSQMessagesViewController

// チャット用画面
class MessageViewController: JSQMessagesViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
