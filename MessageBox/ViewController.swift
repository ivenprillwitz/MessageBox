//
//  ViewController.swift
//  MessageBox
//
//  Created by Iven Prillwitz on 03.03.19.
//  Copyright © 2019 Iven Prillwitz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftButtonImage = UIImage(named: "plus")
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(leftButtonImage, for: .normal)
        
        let rightButtonImage = UIImage(named: "send")
        let rightButton = UIButton(type: .custom)
        rightButton.imageView?.contentMode = .scaleAspectFit
        rightButton.setImage(rightButtonImage, for: .normal)
        
        let messengerBox = MessageBox(leftButton, rightButton)
        messengerBox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messengerBox)
        messengerBox.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        messengerBox.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        messengerBox.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

