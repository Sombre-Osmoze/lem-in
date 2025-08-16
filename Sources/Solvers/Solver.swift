protocol Solver {

    typealias Path = Collection<Room.ID>

    /// Resolve all valid that for the map start to finish.
    func resolve() throws -> [any Path]

}
