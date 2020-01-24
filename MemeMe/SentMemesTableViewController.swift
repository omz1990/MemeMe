//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Omar Mujtaba on 19/1/20.
//  Copyright © 2020 AmmoLogic Training. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var memes: [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView!.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.separatorColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! MemeTableViewCell
        if let meme = memes?[(indexPath as IndexPath).row] {
            cell.title?.text = "\(meme.topText)...\(meme.bottomText)"
            cell.memeImage?.image = meme.memedImage
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeDetailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        memeDetailController.meme = memes?[(indexPath as IndexPath).row]
        self.navigationController!.pushViewController(memeDetailController, animated: true)
    }
}
