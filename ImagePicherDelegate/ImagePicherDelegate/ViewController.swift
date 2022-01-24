//
//  ViewController.swift
//  ImagePicherDelegate
//
//  Created by 양승현 on 2022/01/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var imgView: UIImageView!;
    @IBAction func imgPick(_ sender: Any){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary;
        picker.allowsEditing = true;
        
        self.present(picker, animated: false);
    }

}

