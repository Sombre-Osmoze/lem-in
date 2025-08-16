import Foundation

struct Room: Hashable {
    typealias ID = String
    typealias Coordinates = SIMD2<Int>

    let id: ID
    let coordinates: Coordinates
    var tubes: [ID] = []

    init(from text: Substring) {
        // TODO: Add verification and guard

        let parts = text.split(separator: " ")
        id = String(parts[0])
        coordinates = SIMD2(x: Int(parts[1])!, y: Int(parts[2])!)
    }

    init(_ id: ID, coordinates: Coordinates, tubes: [ID]) {
        self.id = id
        self.coordinates = coordinates
        self.tubes = tubes
    }
}
