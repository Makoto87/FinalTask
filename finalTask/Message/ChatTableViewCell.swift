//
//  ChatTableViewCell.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/29.
//  Copyright © 2019 VERTEX20. All rights reserved.
//


// 作ろうと思いましたができませんでした
import UIKit


class ChatTableViewCell: UITableViewCell {

    // 文章と吹き出しの追加
    let messageLabel = UILabel()
    let bubbleBackGroundView = UIView()
    // 吹き出し
    var leadingConstraint: NSLayoutConstraint!
    var trainingConstraint: NSLayoutConstraint!

    // セルの吹き出しとテキストの設定をセット
    var chatMessage: ChatMessage! {
        didSet {
            bubbleBackGroundView.backgroundColor = chatMessage.isIncoming ? .white : .darkGray
            messageLabel.textColor = chatMessage.isIncoming ? .black : .white

            messageLabel.text = chatMessage.text

            if chatMessage.isIncoming {
                leadingConstraint.isActive = true
                trainingConstraint.isActive = false
            } else {
                leadingConstraint.isActive = false
                trainingConstraint.isActive = true
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // セルの背景を透明にする
        backgroundColor = .clear

        // 吹き出し部分の設定
        bubbleBackGroundView.backgroundColor = .yellow
        bubbleBackGroundView.layer.cornerRadius = 12
        bubbleBackGroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bubbleBackGroundView)

        // 文章部分
        addSubview(messageLabel)
//        messageLabel.backgroundColor = .green
        messageLabel.text = "aaaaaa"
        messageLabel.numberOfLines = 0

        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        // 文章のレイアウト
        let constraints = [
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
        messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),

        // 文章と合うように吹き出しを作る
        bubbleBackGroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
        bubbleBackGroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
        bubbleBackGroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
        bubbleBackGroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16)
        ]
        NSLayoutConstraint.activate(constraints)

        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        leadingConstraint.isActive = false

        trainingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        trainingConstraint.isActive = true

//        messageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
