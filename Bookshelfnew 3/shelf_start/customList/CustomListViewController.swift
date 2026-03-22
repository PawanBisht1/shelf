//
//  CustomListViewController.swift
//  shelf_start
//
//  Created by Pawan Bisht on 12/02/26.
//

import UIKit

class CustomListViewController: UIViewController {
    let names = ["john","fsf","sfsf"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        setupNavigation()
        
    }
    
    private func setupNavigation() {
           title = "New List"

           navigationItem.rightBarButtonItem = UIBarButtonItem(
               title: "Save",
               style: .done,
               target: self,
               action: #selector(saveTapped)
           )
       }

       @objc private func saveTapped() {
           print("Save tapped")
       }
   
}

