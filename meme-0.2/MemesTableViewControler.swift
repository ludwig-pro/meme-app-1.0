//
//  SentMemesTables.swift
//  meme-0.2
//
//  Created by ludwig vantours on 16/04/2020.
//  Copyright © 2020 LudwigVaan. All rights reserved.
//

import Foundation
import UIKit

class MemesTableViewControler: UITableViewController {

  var memes: [Meme]! {
    let object = UIApplication.shared.delegate
    let appDelegate = object as! AppDelegate
    return appDelegate.memes
  }
  

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    tableView?.reloadData()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.memes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
    let meme = self.memes[indexPath.row]
    let text = "\(meme.topText) \(meme.bottomText)"
    cell.textLabel?.text = text
    cell.imageView?.image = meme.original
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath:IndexPath) {
    let memeImageViewController = storyboard?.instantiateViewController(withIdentifier: "MemeImageViewController") as! MemeImageViewController
    memeImageViewController.meme = self.memes[indexPath.row]
    self.navigationController!.pushViewController(memeImageViewController, animated: true)
  }

  
}
