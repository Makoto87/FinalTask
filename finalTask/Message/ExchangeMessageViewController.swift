//
//  ExchangeMessageViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/24.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

class ExchangeMessageViewController: JSQMessagesViewController {

    var messages: [JSQMessage]?

    var incomingBubble: JSQMessagesBubbleImage!
    var outgoingBubble: JSQMessagesBubbleImage!
    var exitcomingBubble:JSQMessagesBubbleImage!


    var incomingAvatar: JSQMessagesAvatarImage!
    var outgoingAvatar: JSQMessagesAvatarImage!

    var uid:String = UUID().uuidString

    var ref: DatabaseReference!
    ref = Database.database().reference()

    let userRef  = .database().reference().child("users")
    let rootRef  = .database().reference()

    let userDefaults = UserDefaults.standard

    //AppDelegateのインスタンスを作り、AppDelegateの変数を使えるようにする。
    let app:AppDelegate =
        (UIApplication.shared.delegate as! AppDelegate)


    override func viewDidLoad() {
        super.viewDidLoad()


        //初回時のみ自分のIDを保存しておく、それ移行は使い回し
        if(userDefaults.string(forKey: "uid") != nil){
            uid = userDefaults.string(forKey: "uid")!
        }else{
            userDefaults.set(uid, forKey: "uid")
        }

        print("自分のuid→\(self.uid)")




        self.app.chatStartFlg = false

        //表示される名前(未実装)
        self.senderDisplayName = "hoge"
        setupFirebase()
        getRoom()
        setupChatUi()

        self.messages = []
    }

    func setupFirebase() {

        //匿名アカウントを認証する
        FIRAuth.auth()?.signInAnonymously() { (user, error) in
            if error != nil {
                //エラー時の処理
                print("失敗")
                return
            }
            //成功時の処理
            print("成功")

        }
    }

    func getRoom(){

        let user = ["name": senderDisplayName as Any,
                    "inRoom": "0",
                    "waitingFlg": "0"] as [String : Any]

        userRef.child(self.uid
            ).setValue(user)


        //一回だけwaitingFlgが１のユーザを取得
        userRef.queryOrdered(byChild: "waitingFlg").queryEqual(toValue: "1").observeSingleEvent(of: .value, with: { (snapshot) in

            let value = snapshot.value as? NSDictionary

            if(value != nil){
                if (value!.count >= 1) {
                    //ルームを作る側の処理
                    print(value!.count);
                    print("value \(value!)")
                    print("↑初回ボタン押下時に、waitingFlgが１のユーザ")

                    self.createRoom(value: value as! Dictionary<AnyHashable, Any>)
                }
            } else {
                //ルームを作られるのを待つ側の処理
                self.userRef.child(self.uid).updateChildValues(["waitingFlg":"1"])
                self.checkMyWaitingFlg();
            }
        });


    }

    //他のユーザが自分とマッチするまで待機する。
    func checkMyWaitingFlg(){
        userRef.child(self.uid).observe(FIRDataEventType.childChanged, with: { (snapshot) in
            print(snapshot)
            let snapshotVal = snapshot.value as! String
            let snapshotKey = snapshot.key

            if (snapshotVal == "0" && snapshotKey == "waitingFlg"){
                self.getJoinRoom()
            }
        })
    }


    //自身のjoinする（している）roomIdを取得
    func getJoinRoom(){
        userRef.child(self.uid).child("inRoom").observeSingleEvent(of: .value, with: { (snapshot) in
            //返ってくる値が１つしか無いからstr型になる
            let snapshotValue = snapshot.value as! String
            self.app.roomId   = snapshotValue

            if(self.app.roomId != "0"){
                print("roomId→ \(self.app.roomId!)")
                print("チャットを開始します")
                self.getMessages()
            }

        })

    }

    //roomIdからそのroomのmessage情報を取得する
    //chatが始まる際必ず呼ばれるmethod
    func getMessages(){

        self.app.chatStartFlg = true


        //【非同期】子要素が増えるたびにmessageに値を追加する。
        rootRef.child("rooms").child(self.app.roomId!).queryLimited(toLast: 100).observe(FIRDataEventType.childAdded, with: { (snapshot) in
            let snapshotValue = snapshot.value as! NSDictionary
            let text          = snapshotValue["text"] as! String
            let sender        = snapshotValue["from"] as! String
            let name          = snapshotValue["name"] as! String

            print("display名前→\(name)")
            let message       = JSQMessage(senderId: sender, displayName: name, text: text)
            self.messages?.append(message!)
            self.finishReceivingMessage()
        })

    }


    func createRoom(value:Dictionary<AnyHashable, Any>){

        //chatを始めるユーザを取得。

        for (key,val) in value {

            //自分のidと違うユーザを取得
            if (key as! String != self.uid){

                //待機中のユーザがいた場合(必ずこの処理で居るが)の処理
                print("待機中のユーザId\(key)")
                self.app.targetId = key as? String

            }
        }


        print("チャット開始するユーザId\(self.app.targetId!)")

        //新規のRoomを作るための数値を取得
        getNewRoomId()


    }

    var count:Int = 1

    //新しくルームを作る際の数値を取得、そしてDBも更新
    func getNewRoomId(){

        FIRDatabase.database().reference().child("roomKeyNum").observeSingleEvent(of: .value, with: { (snapshot) in

            if !(snapshot.value is NSNull){
                self.count = (snapshot.value as! Int) + 1
            }
            FIRDatabase.database().reference()
                .child("roomKeyNum")
                .setValue(self.count)

            self.app.newRoomId = String(self.count)
            self.updateEachUserInfo()

        }) { (error) in
            print(error.localizedDescription)
        }

    }

    //1to1でマッチした場合、お互いの情報を更新する。
    func updateEachUserInfo(){

        self.app.roomId = self.app.newRoomId

        print (self.app.roomId!)
        print (self.app.newRoomId!)
        //ユーザ情報を書き換えていく。
        userRef.child(self.app.targetId!).updateChildValues(["inRoom":self.app.roomId!])
        userRef.child(self.app.targetId!).updateChildValues(["waitingFlg":"0"])
        userRef.child(self.uid).updateChildValues(["inRoom":self.app.roomId!])
        userRef.child(self.uid).updateChildValues(["waitingFlg":"0"])

        //新しく作ったルームのidの情報を取ってくる処理【非同期】
        getMessages()
    }

    func setupChatUi() {
        inputToolbar!.contentView!.leftBarButtonItem = nil
        automaticallyScrollsToMostRecentMessage = true

        //firebaseのfromカラムに入る値
        self.senderId = self.uid


        self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero

        self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero


        let bubbleFactory = JSQMessagesBubbleImageFactory()
        self.incomingBubble = bubbleFactory?.incomingMessagesBubbleImage(
            with: UIColor.gray)
        self.outgoingBubble = bubbleFactory?.outgoingMessagesBubbleImage(
            with: UIColor.jsq_messageBubbleGreen())
        self.exitcomingBubble = bubbleFactory?.incomingMessagesBubbleImage(
            with: UIColor.jsq_messageBubbleRed())
    }



    //別の画面に遷移する直前に実行される処理
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewController/viewWillDisappear/別の画面に遷移する直前")

    }


    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ViewController/viewDidDisappear/別の画面に遷移した直後")

        userRef.child(self.uid).updateChildValues(["waitingFlg":"0"])


        if(self.app.roomId != "0"){
            //相手に退室のメッセージを送るようにする。
            let endMsg = "~相手が退出したよ!!~"
            sendTextToDb(text: endMsg,exitFlg: true)
            self.app.roomId = "0"
        }
    }



    //====================↓JSQMessageの色々======================//


    //メッセージの送信
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {

        self.finishSendingMessage(animated: true)

        if(self.app.chatStartFlg! == true){
            sendTextToDb(text: text)
        }else{
            print("チャット相手検索中です。")
        }

    }

    func sendTextToDb(text: String,exitFlg:Bool = false) {
        //データベースへの送信（後述）

        let rootRef = FIRDatabase.database().reference()

        var tmpSenderId = senderId as String
        if(exitFlg){
            tmpSenderId = "exit"
        }

        let post:Dictionary<String, Any>? = ["from": tmpSenderId,
                                             "name": senderDisplayName,
                                             "text": text]

        let postRef = rootRef.child("rooms").child(self.app.roomId!).childByAutoId()

        postRef.setValue(post)


    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return self.messages?[indexPath.item]
    }

    //バブルの色を返す。
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = self.messages?[indexPath.item]
        if message?.senderId == self.senderId {
            return self.outgoingBubble
        } else if message?.senderId == "exit"{
            return self.exitcomingBubble
        }
        return self.incomingBubble
    }

    //アバター（サムネを返す）
    override func collectionView(_ collectionView: JSQMessagesCollectionView!,
                                 avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        let message = self.messages?[indexPath.item]
        if message?.senderId == self.senderId {
            return self.outgoingAvatar
        }
        return self.incomingAvatar
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.messages?.count)!
    }


}
