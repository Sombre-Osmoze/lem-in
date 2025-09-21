class SolverSingle: Solver {

	enum ResolvingError: Error {
		case noPath
	}

	private let map: Map

	init(map: Map, ants: Set<Ant>) {
		self.map = map
	}

	func resolve() throws -> [any Collection<Room.ID>] {

		let currentPossiblePath: [[Room.ID]]

		let startRoom = try map.room(map.bound.start)

		guard !startRoom.tubes.isEmpty else { throw ResolvingError.noPath }

		var pending: [Room.ID] = [startRoom.id]
		var visited: Set<Room.ID> = []

		while !pending.isEmpty {
			let exploring = pending.removeFirst()
			visited.insert(exploring)
			let nextRoomsToLook = try map.adjacentsRoom(to: exploring).subtracting(visited)

			// TODO: Clear

			dump(nextRoomsToLook, name: "next")
			// Verify if one of the room is the target else explore rooms
			guard nextRoomsToLook.contains(map.bound.end) else {
				// Next room pending exploration
				pending.append(contentsOf: nextRoomsToLook)
				continue
			}

			// TODO: Retreive full path
			return [[exploring, map.bound.end]]
		}

		return []
	}

}
