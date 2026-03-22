
import Foundation

class BookshelfData: Codable {

    var sections: [ShelfSection] = []

    init() {
        do {
            let response = try load()
            sections = response.sections
            print("Loaded sections:", sections.count)
        } catch {
            print(error.localizedDescription)
        }
    }

    enum CodingKeys: String, CodingKey {
        case sections
    }
}
extension BookshelfData {

    /// Load bookshelf from a JSON file
    func load(from filename: String = "bookshelf") throws -> BookshelfData {

        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            throw NSError(
                domain: "BookshelfResponse",
                code: 404,
                userInfo: [NSLocalizedDescriptionKey: "bookshelf.json not found"]
            )
        }

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()

        // Debug print (optional)
        print(String(data: data, encoding: .utf8) ?? "")

        do {
            return try decoder.decode(BookshelfData.self, from: data)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }

    /// Load bookshelf from JSON data
    func decode(from data: Data) throws -> BookshelfData {
        let decoder = JSONDecoder()
        return try decoder.decode(BookshelfData.self, from: data)
    }
}
extension BookshelfData {

    /// Get books for a specific shelf
    func books(for shelf: ShelfType) -> [Book] {
        sections.first { $0.shelfType == shelf }?.books ?? []
    }

    /// Get section for a shelf
    func section(for shelf: ShelfType) -> ShelfSection? {
        sections.first { $0.shelfType == shelf }
    }

    /// Get all books (flat list)
    var allBooks: [Book] {
        sections.flatMap { $0.books }
    }

    /// Get books grouped by shelf (perfect for UICollectionView)
    var booksBySection: [ShelfType: [Book]] {
        var grouped: [ShelfType: [Book]] = [:]

        for section in ShelfType.allCases {
            grouped[section] = books(for: section)
        }

        return grouped
    }
}

