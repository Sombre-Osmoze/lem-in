protocol Algorithm {

    typealias Path = Collection<Room.ID>

    static func search(in map: Map) throws -> [any Path]
}
