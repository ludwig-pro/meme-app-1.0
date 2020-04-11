//
//  ImagePickerDelegate.swift
//  meme-0.2
//
//  Created by ludwig vantours on 09/04/2020.
//  Copyright © 2020 LudwigVaan. All rights reserved.
//

import Foundation
import UIKit

class ImagePickerDelegate : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
    print("picker")
    picker.dismiss(animated: true, completion: nil)
  }
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    print("cancel")
    picker.dismiss(animated: true, completion: nil)
  }
}
