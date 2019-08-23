//
//  SearchViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/23.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource {

    // 検索バーへ行くボタン
    @IBOutlet weak var searchButton: UIButton!
    // 場所のコレクションビュー
    @IBOutlet weak var collectionVIew1: UICollectionView!
    // ジャンルのコレクションビュー
    @IBOutlet weak var categoryCollectionView: UICollectionView!




    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // コレクションビューを使うためのもの
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8 // 表示するセルの数
    }
    // コレクションビューを使うためのもの
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) // 表示するセルを登録(先程命名した"Cell")
        cell.backgroundColor = .orange  // セルの色
        return cell
    }

    // 検索ボタン
    @IBAction func searchButton(_ sender: Any) {
        performSegue(withIdentifier: "sendSearchBar", sender: nil)
    }
    



}
