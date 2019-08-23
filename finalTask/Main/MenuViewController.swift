//
//  MenuViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/23.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    // メニューの部分
    @IBOutlet weak var menuView: UIView!
    // アイコンのイメージビュー
    @IBOutlet weak var iconImageView: UIImageView!
    // 名前のラベル
    @IBOutlet weak var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        iconImageView.image = #imageLiteral(resourceName: "splashRogoRemake")
        nameLabel.text = "堀田 真"
    }

    // メニュービューを出すためのメソッド
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // メニューの位置を取得する
        let menuPos = self.menuView.layer.position
        // 初期位置を画面の外側にするため、メニューの幅の分だけマイナスする
        self.menuView.layer.position.x = -self.menuView.frame.width
        // 表示時のアニメーションを作成する
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {
            self.menuView.layer.position.x = menuPos.x
            },
            completion: { bool in
            })
    }

    // メニューエリア以外タップ時の処理
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            if touch.view?.tag == 1 {
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    options: .curveEaseIn,
                    animations: {
                    self.menuView.layer.position.x = -self.menuView.frame.width
                    },
                    completion: { bool in
                    self.dismiss(animated: true, completion: nil)
                    }
                )
            }
        }
    }
}


