//
//  ViewController.swift
//  Swaply
//
//  Created by Владислав Абушенко on 31.03.2026.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let button = ButtonWithImage()
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}
