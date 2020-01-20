//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Omar Mujtaba on 19/1/20.
//  Copyright © 2020 AmmoLogic Training. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var memes: [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView!.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell")!
        if let meme = memes?[(indexPath as IndexPath).row] {
            cell.textLabel?.text = "\(meme.topText)...\(meme.bottomText)"
            cell.imageView?.image = meme.memedImage
        }
        return cell
    }
}
