//
//  CollectionViewCell.swift
//  shelf_start
//
//  Created by GEU on 10/02/26.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet var authorName: UILabel!
    @IBOutlet var bookName: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var index: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    func configure(with book: Book) {
        authorName.text = book.author
        bookName.text = book.title
        index.text = "\(book.id)"
        imageView.image = UIImage(named: book.coverImageName)
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
    }

}
