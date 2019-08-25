//
//  LoginViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/24.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class LoginViewController: UIViewController {

    // メールテキストフィールド
    @IBOutlet var emailTextField: UITextField!
    // パステキストフィールド
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // タイムラインへ遷移するメソッド。認証成功時に組み込む
    func toTimeLine(){
        // storyboardのfileの特定
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // 移動先のncをインスタンス化。ナビゲーションバーを表示させるために無理やり作ってる
        let nc = storyboard.instantiateInitialViewController() as! UITabBarController
        self.present(nc, animated: true)
    }

    // エラーが返ってきた場合のアラート。Error型が使われている
    func showErrorAlert(error: Error?) {
        // 表示される文字
        // error?.localizedDescription は firebaseが用意してくれているエラーメッセージ機能
        let alert = UIAlertController(title: "入力エラー", message: error?.localizedDescription, preferredStyle: .alert)
        // OKボタン
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        // アラートにOKボタンを加える
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }

    // 新規作成ボタン
    @IBAction func newAccountButton(_ sender: Any) {

        // emailとpasswordが入っているか確認する
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        // アカできるか判断する
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            // エラーだった場合。errorは Error型。これはnilもあるのでoptional型となっている。nilが入ったらエラー
            if let error = error {
                print("認証失敗")
                // アラートで通知
                self.showErrorAlert(error: error)
            // 成功した場合
            } else {
                print("新規作成成功")
                // ユーザーIDをオプショナルバインディングする
                guard let uid = Auth.auth().currentUser?.uid else {
                    return
                }
                // コレクションを指定して、ユーザーごとにドキュメントを作る
                let db = Firestore.firestore()
                let users = db.collection("users").document(uid)
                // ドキュメントにメアドとパスワードを入れる
                let userData: NSDictionary = ["email": email, "password": password]
                users.updateData(userData as! [String : Any])
                // タイムラインに遷移する
                self.toTimeLine()
            }
        })
    }
    // ログインボタン
    @IBAction func loginButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        // ログイン処理。サインインのメソッド
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                self.showErrorAlert(error: error)
                print("ログイン失敗")
            } else {
                print("ログイン成功")
                self.toTimeLine()
            }
        })
    }
}
