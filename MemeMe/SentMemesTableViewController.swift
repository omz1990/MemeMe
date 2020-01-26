//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Omar Mujtaba on 19/1/20.
//  Copyright © 2020 AmmoLogic Training. All rights reserved.
//

import UIKit

class SentMemesTableViewController: SentMemesBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload the data when returning to the screen
        self.tableView!.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Remove the separators from the table
        self.tableView!.separatorColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Build and populate our custom MemeTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! MemeTableViewCell
        
        if let meme = memes?[(indexPath as IndexPath).row] {
            cell.title?.text = "\(meme.topText)...\(meme.bottomText)"
            cell.memeImage?.image = meme.memedImage
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.openMemeDetailsViewController(meme: memes?[(indexPath as IndexPath).row])
    }
}
