//
//  profileChangeViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/22.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

import UIKit

class ProfileChangeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = false

        // Do any additional setup after loading the view.
    }

    // 変更ボタン。画面遷移する
    @IBAction func infoChangeButton(_ sender: Any) {
        self.dismiss(animated: true)
    }



}
