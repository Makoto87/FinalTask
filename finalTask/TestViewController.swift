//
//  TestViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/20.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBOutlet weak var placeTextField: UITextField!

    
    @IBAction func test(_ sender: Any) {

        view.backgroundColor = .gray
    }



    func buttonEnabled() {

        placeTextField.text?.count





    }






}
