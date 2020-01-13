//
//  ViewController.swift
//  MemeMe
//
//  Created by Omar Mujtaba on 12/1/20.
//  Copyright © 2020 AmmoLogic Training. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    // MARK: Class variables
    @IBOutlet private weak var topBar: UIToolbar!
    @IBOutlet private weak var bottomBar: UIToolbar!
    @IBOutlet private weak var imagePickerView: UIImageView!
    @IBOutlet private weak var cameraButton: UIBarButtonItem!
    private var memedImage: UIImage!
    
    // MARK: Top Text Definition
    @IBOutlet private weak var topText: UITextField!
    private let topDefaultText = "TOP"
    private let topTextDelegate: MemeTextDelegate
    
    // MARK: Bottom Text Definition
    @IBOutlet private weak var bottomText: UITextField!
    private let bottomDefaultText = "BOTTOM"
    private let bottomTextDelegate: MemeTextDelegate
    
    // MARK: Text Attributes Definitions
    private let memeTextAttributes: [NSAttributedString.Key: Any] = [
         NSAttributedString.Key.strokeColor: UIColor.black,
         NSAttributedString.Key.foregroundColor: UIColor.white,
         NSAttributedString.Key.strokeWidth: -2.0]
    
    // MARK: Handle View Initialization
    required init?(coder aDecoder: NSCoder) {
        // Initialize the text delegates
        topTextDelegate = MemeTextDelegate(defaultText: topDefaultText)
        bottomTextDelegate = MemeTextDelegate(defaultText: bottomDefaultText)
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Subscribe to keyboard events
        subscribeToKeyboardWillShowNotifications()
        subscribeToKeyboardWillHideNotifications()
        // Set camera button visibility
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Unsubscribe keyboard events
        unsubscribeFromKeyboardWillShowNotifications()
        unsubscribeFromKeyboardWillHideNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Inilialize text fields
        setMemeTextAttributes(textField: topText, defaultText: topDefaultText, delegate: topTextDelegate)
        setMemeTextAttributes(textField: bottomText, defaultText: bottomDefaultText, delegate: bottomTextDelegate)
    }
    
    // MARK: Set text attributes
    private func setMemeTextAttributes(textField: UITextField, defaultText: String, delegate: MemeTextDelegate) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.text = defaultText
        textField.delegate = delegate
        textField.borderStyle = UITextField.BorderStyle.none
    }

    // MARK: Pick an image Actions
    @IBAction private func pickAnImageFromAlbum(_ sender: Any) {
        pickAnImage(sourceType: .photoLibrary)
    }
    
    @IBAction private func pickAnImageFromCamera(_ sender: Any) {
        pickAnImage(sourceType: .camera)
    }
    
    private func pickAnImage(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: Image Picker Controller Delegate Implementation
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Handle keyboard will show
    private func subscribeToKeyboardWillShowNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    private func unsubscribeFromKeyboardWillShowNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        view.frame.origin.y = 0
        // Only shift the view up if the bottom text field has been selected
        if bottomText.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }

    private func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    // MARK: Handle Keyboard will hide
    private func subscribeToKeyboardWillHideNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func unsubscribeFromKeyboardWillHideNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillHide() {
        view.frame.origin.y = 0
    }
    
    // MARK: Generate Meme
    @IBAction func shareMeme(_ sender: Any) {
        memedImage = generateMemedImage()
        openShareActivity()
    }
    
    private func openShareActivity() {
        // Prepare Activity view controller
        let imagesToShare = [ memedImage! ]
        let activityViewController = UIActivityViewController(activityItems: imagesToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // Present
        self.present(activityViewController, animated: true, completion: save)
    }
    
    private func generateMemedImage() -> UIImage {
        // Remove toolbars before using the frame to generate the view
        toggleToolbars(visible: false)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // Make the toolbars visible again
        toggleToolbars(visible: true)

        return memedImage
    }
    
    func save() {
        // This section is to be implemented in the next Project submission
        
        // Create the meme
        // let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
    }
    
    private func toggleToolbars(visible: Bool) {
        topBar.isHidden = !visible
        bottomBar.isHidden = !visible
    }
    
    // MARK: Cancel and reset the view
    @IBAction private func cancel(_ sender: Any) {
        topText.text = topDefaultText
        bottomText.text = bottomDefaultText
        toggleToolbars(visible: true)
        imagePickerView.image = nil
    }
}
