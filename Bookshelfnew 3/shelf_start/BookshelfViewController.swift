//
//  ViewController.swift
//  shelf_start
//
//  Created by GEU on 10/02/26.
//

import UIKit

class BookshelfViewController: UIViewController {
   

    var selectedSection: ShelfSection?



    func didTapHeader(section: Int) {
        selectedSection = sections[section]
        performSegue(withIdentifier: "showBookDetail", sender: nil)
        
    }

   


    @IBOutlet var ColllectionView: UICollectionView!
    var book = BookshelfData()
    var bookList : [Book] = []
    var bookwantto : [Book] = []
    var bookfinished : [Book] = []
    var sections: [ShelfSection] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bookshelf"
        sections = book.sections
       // tablebookdetail.dataSource = self

        // Do any additional setup after loading the view.
      // sections = JSONLoader.loadBookshelf()
        

        bookList = book.books(for: .currentlyReading)
        bookwantto = book.books(for:.wantToRead)
        bookfinished = book.books(for:.finished)
        print("Loaded : \(bookList.count)")
        // register
        ColllectionView.register(UINib(nibName: "CollectionViewCell",bundle: nil), forCellWithReuseIdentifier:  "CollectionViewCell")
        //header
        ColllectionView.register(
            UINib(nibName: "HeaderView", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "HeaderView"
        )

        ColllectionView.collectionViewLayout = generateLayout()
        ColllectionView.dataSource = self
        ColllectionView.delegate = self


       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard segue.identifier == "showSectionDetail" else { return }

        let vc = segue.destination as! BookDetailViewController

        if let sectionIndex = sender as? Int {
            vc.section = sections[sectionIndex]
        }
    }






}
extension BookshelfViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].books.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CollectionViewCell",
            for: indexPath
        ) as! CollectionViewCell

        let book = sections[indexPath.section].books[indexPath.item]
        cell.configure(with: book)

        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        print(" Header created for section:", indexPath.section)

        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "HeaderView",
            for: indexPath
        ) as! HeaderView

        let section = sections[indexPath.section]

        header.configure(title: section.title, section: indexPath.section)

//        header.buttonAction = { [weak self] sectionIndex in
//            print("Header action called:", sectionIndex)
//            self?.selectedSection = self?.sections[sectionIndex]
//            self?.performSegue(withIdentifier: "showSectionDetail", sender: nil)
//        }
        
        header.buttonAction = { [weak self] in self?.performSegue(withIdentifier: "showSectionDetail", sender: indexPath.section)}

        return header
    }


    
    func generateLayout() -> UICollectionViewLayout {
        
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.generateSection()
        }
    }
    
    
    func generateSection() -> NSCollectionLayoutSection {
        
        // ITEM (single cell)
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(90)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // GROUP (column that scrolls horizontally)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(320),   //  smaller than screen
            heightDimension: .estimated(300)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            repeatingSubitem : item,
            count: 3
        )
        
        group.interItemSpacing = .fixed(8)
        
        // SECTION
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 16,
            leading: 16,
            bottom: 16,
            trailing: 16
        )
        // 🔥ADD HEADER TO LAYOUT
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)
        )

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        section.boundarySupplementaryItems = [header]

        
        return section
    }
    
    
}

extension BookshelfViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let selectedSection = sections[indexPath.section]
        
        
    }
}
