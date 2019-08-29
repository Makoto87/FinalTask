//
//  SearchViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/23.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UICollectionViewDelegate,  UICollectionViewDataSource {

    // 検索バーへ行くボタン
    @IBOutlet weak var searchButton: UIButton!
    // 場所のコレクションビュー
    @IBOutlet weak var collectionVIew1: UICollectionView!

    // 場所のコレクションビュー
    var collections = ["osaka", "shibuya", "shinjuku", "tokyo", "ikebukuro", "skytree", "tokyotower"]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionVIew1.delegate = self
        collectionVIew1.dataSource = self
    }

    // セルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return collections.count
    }

    // セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // どの処理をするかチェック
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)

        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        imageView.image = UIImage(named: collections[indexPath.row])

        return cell
    }

    // 検索ボタン
    @IBAction func searchButton(_ sender: Any) {
        performSegue(withIdentifier: "sendSearchBar", sender: nil)
    }
}
