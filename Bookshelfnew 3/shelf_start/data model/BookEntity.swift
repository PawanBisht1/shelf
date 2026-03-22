import Foundation

struct Book: Codable, Identifiable {

    let id: String
    let title: String
    let author: String
    let coverImageName: String
    let position: Int
    let description: String   // Added because JSON has it
}

// MARK: - Shelf Section
// Equivalent to how `ClubSection` is used in Club entities
struct ShelfSection: Codable, Identifiable {

    // Derived identifier (NOT part of JSON)
    var id: ShelfType { shelfType }

    let shelfType: ShelfType
    let title: String
    let books: [Book]
}

// MARK: - Shelf Type Enum
// Equivalent to `ClubSection` enum
enum ShelfType: String, CaseIterable, Codable {

    case currentlyReading
    case wantToRead
    case finished

    var displayName: String {
        switch self {
        case .currentlyReading:
            return "Currently Reading"
        case .wantToRead:
            return "Want To Read"
        case .finished:
            return "Finished"
        }
    }
}
// MARK: - Root Response
// Equivalent to `ClubsData` root JSON
struct BookshelfResponse: Codable {
    let sections: [ShelfSection]
}
// MARK: - Optional UI Helper
// Equivalent to `ClubList`
struct ShelfList {
    let title: String
    let iconName: String
}
// MARK: - Create Shelf Section
// Equivalent to `CreateClubSection`
enum CreateShelfSection: Int, CaseIterable {
    case cover
    case title
    case author
    case shelf
}
