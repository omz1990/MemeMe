//
//  SentMemesBaseViewController.swift
//
//  A base class for the Sent Memes to place all the common stuff here
//
//  Created by Omar Mujtaba on 26/1/20.
//  Copyright © 2020 AmmoLogic Training. All rights reserved.
//

import UIKit

open class SentMemesBaseViewController: UIViewController {
    
    internal var memes: [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    internal func openMemeDetailsViewController(meme: Meme!) {
        let memeDetailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        memeDetailController.meme = meme
        self.navigationController!.pushViewController(memeDetailController, animated: true)
    }
}
