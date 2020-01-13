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

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    // MARK: Top Text Definition
    @IBOutlet weak var topText: UITextField!
    private let topDefaultText = "TOP"
    private let topTextDelegate: MemeTextDelegate
    
    // MARK: Bottom Text Definition
    @IBOutlet weak var bottomText: UITextField!
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
        // Set camera button visibility
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
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
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        pickAnImage(sourceType: .photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
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
}
