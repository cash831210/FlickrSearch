//
//  ViewController.swift
//  FlickrSearch
//
//  Created by 莊鎧旭 on 2020/6/22.
//  Copyright © 2020 Cash. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchTitleTextField: UITextField!
    @IBOutlet weak var countNumberTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchTitleTextField.delegate = self
        countNumberTextField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if searchTitleTextField.text != "" && countNumberTextField.text != "" {
            searchButton.isEnabled = true
            searchButton.backgroundColor = UIColor.blue
        }else if searchTitleTextField.text! == "" || countNumberTextField.text! == "" {
            searchButton.isEnabled = false
            searchButton.backgroundColor = UIColor.gray
        }
        return true
    }

    @IBAction func editingChanged(_ sender: UITextField) {
        if searchTitleTextField.text != "" && countNumberTextField.text != "" {
            searchButton.isEnabled = true
            searchButton.backgroundColor = UIColor.blue
        }else if searchTitleTextField.text! == "" || countNumberTextField.text! == "" {
            searchButton.isEnabled = false
            searchButton.backgroundColor = UIColor.gray
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func textFieldDidEndEditing(_ textField: UITextField) -> Bool {
        if searchTitleTextField.text != "" && countNumberTextField.text != "" {
            searchButton.isEnabled = true
            searchButton.backgroundColor = UIColor.blue
        }else if searchTitleTextField.text! == "" || countNumberTextField.text! == "" {
            searchButton.isEnabled = false
            searchButton.backgroundColor = UIColor.gray
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let flickrView = segue.destination as! FlickrSearchCollectionViewController
                flickrView.searchTitle = self.searchTitleTextField.text
                let countNumber = Int(countNumberTextField.text!)
                flickrView.countNumber = countNumber
        }
}

