//
//  BookDetailViewController.swift
//  shelf_start
//
//  Created by Pawan Bisht on 12/02/26.
//

import UIKit

class BookDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var section: ShelfSection?
 

       override func viewDidLoad() {
           super.viewDidLoad()

           title = section?.title
           tableView.dataSource = self
           tableView.rowHeight = UITableView.automaticDimension
           tableView.estimatedRowHeight = 120
           
       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension BookDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.section?.books.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "bookDetailCell1",
            for: indexPath
        ) as! bookDetailCell1
        
        if let book = section?.books[indexPath.row] {
            cell.configure(with: book)
        }
        
        return cell
    }
}
