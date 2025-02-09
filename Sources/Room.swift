import Foundation

struct Room {
    typealias ID = String

    let id: ID
    let coordinates: SIMD2<Int>
    var tubes: [ID] = []

    init(from text: Substring) {
        // TODO: Add verification and guard

        let parts = text.split(separator: " ")
        id = String(parts[0])
        coordinates = SIMD2(x: Int(parts[1])!, y: Int(parts[2])!)
    }
}
