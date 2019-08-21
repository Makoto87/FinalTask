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

import UIKit
import GuillotineMenu   // サイドメニューが出てくるものをインポート


// テーブルビューとサイドメニューのクラスを追加
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {

    // テーブルビュー。タグ付けしている
    // 1から順番にアイコン・場所・日時・コメント・写真
    @IBOutlet weak var tableView: UITableView!

    // ライブラリサイドメニューを使うためのもの
//    let mainViewController = storyboard!.instantiateViewController(withIdentifier: "MainViewController")
//    mainViewController.modalPresentationStyle = .custom
//    mainViewController.transitioningDelegate = self
//
//    presentationAnimator.supportView = navigationController!.navigationBar
//    presentationAnimator.presentButton = sender
//    present(menuViewController, animated: true, completion: nil)


    override func viewDidLoad() {
        super.viewDidLoad()

        // tableviewの delegateとdatasourseを接続
        tableView.delegate = self
        tableView.dataSource = self
        tableView.viewWithTag(6)?.isHidden = true

    }

    // セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    // セルの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)



        return cell
    }

    // セルの遷移設定
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // セグエで画面遷移
        performSegue(withIdentifier: "toDetailSegue", sender: nil)
    }

    // 投稿ボタン。画面遷移する
    @IBAction func sendButton(_ sender: Any) {

        performSegue(withIdentifier: "sendPost", sender: nil)

    }

//    // 遷移するときに情報を送る処理
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "sendPost", let svc = segue.destination as? PostViewController  else{
//            // destinationはUIの上位互換のようなもの
//            // identifierがnameSegue かつ destinationがprofileControllerなら動く。asは=のようなもの。
//            return
//        }
//
//    }








}

//// サイドメニューを使うためのメソッド
//extension ViewController: UIViewControllerTransitioningDelegate {
//
//    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        presentationAnimator.mode = .presentation
//        return presentationAnimator
//    }
//
//    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        presentationAnimator.mode = .dismissal
//        return presentationAnimator
//}
