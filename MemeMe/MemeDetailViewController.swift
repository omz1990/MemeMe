//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Omar Mujtaba on 24/1/20.
//  Copyright © 2020 AmmoLogic Training. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var meme: Meme!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let image = meme.memedImage {
            imageView.image = image
        }
    }
}
