import Foundation

struct Room: Hashable, Equatable {
    typealias ID = String
    typealias Coordinates = SIMD2<Int>

    let id: ID
    let coordinates: Coordinates
    var tubes: Set<ID> = []

    init(from text: Substring) {
        // TODO: Add verification and guard

        let parts = text.split(separator: " ")
        id = String(parts[0])
        coordinates = SIMD2(x: Int(parts[1])!, y: Int(parts[2])!)
    }

    init(_ id: ID, coordinates: Coordinates, tubes: Set<ID>) {
        self.id = id
        self.coordinates = coordinates
        self.tubes = tubes
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
