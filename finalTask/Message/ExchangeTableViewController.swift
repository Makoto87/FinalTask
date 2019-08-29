//
//  ExchangeTableViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/29.
//  Copyright © 2019 VERTEX20. All rights reserved.
//



// 作ろうと思いましたができませんでした
import UIKit

struct ChatMessage {
    let text: String
    let isIncoming: Bool
    let date: Date
}

extension Date {
    static func dateFromCustomString(customString: String) -> Date {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"

        return dateFormatter.date(from: customString) ?? Date()
    }
}

class ExchangeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!

    private let cellId = "messageCell"

    let messageFromServer = [
        ChatMessage(text: "明日飯くおうぜ", isIncoming: true, date: Date.dateFromCustomString(customString: "08/26/2019")),
        ChatMessage(text: "どうすか", isIncoming: true, date: Date.dateFromCustomString(customString: "08/26/2019")),
        ChatMessage(text: "ええで", isIncoming: false, date: Date.dateFromCustomString(customString: "08/27/2019")),
        ChatMessage(text: "やったー", isIncoming: false, date: Date.dateFromCustomString(customString: "08/27/2019"))
    ]

    private func attemptToAssembleGroupedMessages() {
        let groupedMessages = Dictionary(grouping: messageFromServer) { (elemnt) -> Date in
            return elemnt.date
        }

        let sortedKeys = groupedMessages.keys.sorted()
        sortedKeys.forEach { (key) in
            let values = groupedMessages[key]
            chatMessages.append(values ?? [])

        }
    }

    var chatMessages = [[ChatMessage]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        // テーブルビューの設定
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }

    // セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }

    class DateHeaderLabel: UILabel {

        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .black
            textColor = .white
            textAlignment = .center
            translatesAutoresizingMaskIntoConstraints = false
            font = UIFont.boldSystemFont(ofSize: 14)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override var intrinsicContentSize: CGSize{
            // superクラスを持ってくる
            let originalContentSize = super.intrinsicContentSize
            // 高さと吹き出しの設定
            let height = originalContentSize.height + 12
            layer.cornerRadius = height / 2
            layer.masksToBounds = true
            return CGSize(width: originalContentSize.width + 20, height: height)
        }
    }

    // セクションのヘッダー
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if let firstMessagerInSection = chatMessages[section].first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let dateString = dateFormatter.string(from: firstMessagerInSection.date)

            let label = DateHeaderLabel()
            label.text = dateString

            let containerView = UIView()
            containerView.addSubview(label)
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true

            return containerView

        }
        return nil
    }

    // 高さ
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    // セル数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return chatMessages[section].count
    }

    // セルの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatTableViewCell

        let chatMessage = chatMessages[indexPath.section][indexPath.row]

        cell.chatMessage = chatMessage

        return cell
    }
}
