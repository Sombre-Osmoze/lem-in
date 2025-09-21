class BreathFirstSearch: Algorithm {

    static func search(in map: Map) throws -> [any Collection<Room.ID>] {
        var visited: Set<Room.ID> = []
        var unexplored: [Room.ID] = [map.bound.start]

        let possiblesPath: [[Room.ID]] = []

        while !unexplored.isEmpty {
            let exploring = unexplored.removeFirst()
            visited.insert(exploring)

            let next = try map.adjacentsRoom(to: exploring).subtracting(visited)

            // TODO: Clear  possible path if current explored room does havve neighbors

            // Verify if one of the room is the target else explore rooms
            guard next.contains(map.bound.end) else {
                // Next room pending exploration
                unexplored.append(contentsOf: next)
                continue
            }

            // TODO: Retreive full path
            // return [[exploring, map.bound.end]]
        }

        // If nothing left to explore return possible path that contains the target.
        return possiblesPath.filter { path in
            path.contains(map.bound.end)
        }
    }
}
