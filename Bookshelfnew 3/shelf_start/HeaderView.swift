//
//  SectionHeaderReusableView.swift
//  shelf_start
//
//  Created by GEU on 11/02/26.
//

import UIKit

class HeaderView: UICollectionReusableView {

    
    @IBOutlet var headerButton: UIButton!
//    func configure(with title: String) {
//        headerButton.setTitle(title, for: .normal)
//    }
 //   var sectionIndex: Int = 0
   //     var buttonAction: ((Int) -> Void)?
    
    
    
//    var sectionIndex: Int = 0
        var buttonAction: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
//        isUserInteractionEnabled = true
//        headerButton.isUserInteractionEnabled = true
//        print("HeaderView awakeFromNib")
//        
//        chevronImage.translatesAutoresizingMaskIntoConstraints = false
//        chevronImage.leadingAnchor.constraint(equalTo: headerButton.trailingAnchor, constant: 8),
//        chevronImage.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -8),
        
    }
        
    @IBOutlet weak var chevronImage: UIImageView!
    
     @IBAction func headerButtonTapped(_ sender: UIButton) {
//         print("Header tapped:", sectionIndex)
         
         buttonAction?()
     }
    func configure(title: String, section: Int) {
        headerButton.setTitle(title, for: .normal)
//                sectionIndex = section
        }
}
