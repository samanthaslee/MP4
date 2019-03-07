//
//  Home.swift
//  MP4
//
//  Created by Elizabeth Lee on 3/5/19.
//  Copyright © 2019 Sam Lee. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var logoImageView: UIImageView!
    
    var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeSetUp()

    }
    
    @objc func homeSetUp() {
        //logoImageView = UIImageView(frame: CGRect(x: 0, y: 100, width: view.frame.width - 20, height: view.frame.height - 115))
        logoImageView = UIImageView(frame: CGRect(x: 10, y: 100, width: view.frame.width - 20, height: view.frame.height - 110))
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.image = UIImage(named: "welcomepage")
        view.addSubview(logoImageView)
        
        view.backgroundColor = UIColor(red:0.02, green:0.09, blue:0.30, alpha:1.0)
        
        startButton = UIButton(frame: CGRect(x: 40, y: 680, width: view.frame.width - 80, height: 40))
        startButton.setTitle("Begin Search", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        startButton.layer.cornerRadius = 5
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).cgColor
        //startButton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).CGColor
        startButton.backgroundColor = UIColor(red:0.24, green:0.28, blue:0.45, alpha:1.0)
        
        
        view.addSubview(startButton)
        
    }
    
    @objc func startButtonClicked() {
        performSegue(withIdentifier: "toBegin", sender: self)
        print("clicked")
    }

}
