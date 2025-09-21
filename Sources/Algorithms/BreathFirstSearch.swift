/// Implemtation of BreadthFirstSearch that find all path in a graph
class BreathFirstSearchAll: Algorithm {

    static func search(in map: Map) throws -> [any Collection<Room.ID>] {
        var visited: Set<Room.ID> = []

        var possiblesPath: [[Room.ID]] = [[map.bound.start]]
        var validsPath: [[Room.ID]] = []

        while !possiblesPath.isEmpty {
            let exploring = possiblesPath.removeFirst()
            visited.insert(exploring.last!)

            let next = try map.adjacentsRoom(to: exploring.last!).subtracting(visited)

            // If no room to explore further close paths that end with the current explored room
            guard !next.isEmpty else {
                possiblesPath.removeAll { path in
                    path.last == exploring.last
                }
                continue
            }

            // Verify if one of the room is the target else explore rooms
            guard !next.contains(map.bound.end) else {
                var foundValidPath = [Room.ID](exploring)
                foundValidPath.append(map.bound.end)
                validsPath.append(foundValidPath)
                continue
            }

            // Next room pending exploration
            possiblesPath.append(
                contentsOf: next.map { room in
                    var newPaths = [Room.ID].init(exploring)
                    newPaths.append(room)
                    return newPaths
                })
        }

        return validsPath
    }
}
