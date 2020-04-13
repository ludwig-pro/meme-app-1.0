//
//  ViewController.swift
//  meme-0.2
//
//  Created by ludwig vantours on 09/04/2020.
//  Copyright © 2020 LudwigVaan. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate  {

  @IBOutlet weak var imagePickView: UIImageView!
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  @IBOutlet weak var topText: UITextField!
  @IBOutlet weak var bottomText: UITextField!
  @IBOutlet weak var share: UIBarButtonItem!
  
  struct Meme {
    var topText: String;
    var bottomText: String;
    var original: UIImage;
    var memedImage: UIImage;
  }
  
  // Delegate object
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){    
    if let image = info[.originalImage] as? UIImage {
      imagePickView.image = image
      share.isEnabled = true
      
    }
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField){
    if(textField.text == "TOP"){
      textField.text = ""
    }
    if(textField.text == "BOTTOM"){
      textField.text = ""
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    
    return true;
  }
  
   // LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    configureTextField(topText, text: "TOP")
    configureTextField(bottomText, text: "BOTTOM")

  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    subscribeToKeyboardNotifications()
    share.isEnabled = false
    cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    
    super.viewWillDisappear(animated)
    unsubscribeFromKeyboardNotifications()
  }
  
  // UI Method
  
  @IBAction func pickImage(_ sender: Any) {
    getImagePicker(.photoLibrary)
  }
  
  @IBAction func pickCamera(_ sender: Any) {
    getImagePicker(.camera)
  }
  
  func getImagePicker(_ source: UIImagePickerController.SourceType){
    let pickerController = UIImagePickerController()
    pickerController.delegate = self
    pickerController.sourceType = source
    present(pickerController, animated: true, completion: nil)
  }
    
  @IBAction func shareMeme(_ sender: Any) {
//    generate a memed image
    let meme = generateMemedImage()
//    define an instance of the ActivityViewController
    let activity = UIActivityViewController.init(activityItems: [meme], applicationActivities: nil)
    activity.completionWithItemsHandler = {(activity, success, items, error) in
    if(success){
      self.save()
      }}
//    pass the ActivityViewController a memedImage as an activity item
//    present the ActivityViewController
    present(activity, animated: true, completion: nil)

  }
  
  
  
  // Class Method
    // keyboard
  func subscribeToKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  func unsubscribeFromKeyboardNotifications() {
    
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc func keyboardWillShow(_ notification:Notification) {
    if(bottomText.isEditing){
    view.frame.origin.y -= getKeyboardHeight(notification)
    }
  }
  
  @objc func keyboardWillHide(_ notification:Notification) {
    view.frame.origin.y = 0
  }
  
  func getKeyboardHeight(_ notification:Notification) -> CGFloat {
    
    let userInfo = notification.userInfo
    let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
    return keyboardSize.cgRectValue.height
  }

  func save() {
    // Create the meme
    _ = Meme(topText: topText.text!, bottomText: bottomText.text!, original: imagePickView.image!, memedImage: generateMemedImage())

  }
  
  func generateMemedImage() -> UIImage {
    self.tabBarController?.tabBar.isHidden = true
    self.navigationController?.navigationBar.isHidden = true
    
    // Render view to an image
    UIGraphicsBeginImageContext(self.view.frame.size)
    view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
    let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    self.tabBarController?.tabBar.isHidden = false
    self.navigationController?.navigationBar.isHidden = false
    
    return memedImage
  }

  
  // Style
  let memeTextAttributes: [NSAttributedString.Key: Any] = [
    NSAttributedString.Key.strokeColor: UIColor.black ,
    NSAttributedString.Key.foregroundColor: UIColor.white,
    NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    NSAttributedString.Key.strokeWidth:  -3.2,
  ]
  
  func configureTextField(_ textField: UITextField, text: String) {
    textField.delegate = self
    textField.text = text
    textField.defaultTextAttributes = memeTextAttributes
    textField.textAlignment = .center

  }

  
  
}




