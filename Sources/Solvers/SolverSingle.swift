class SolverSingle: Solver {

	enum ResolvingError: Error {
		case noPath
	}

	private let map: Map

	init(map: Map, ants: Set<Ant>) {
		self.map = map
	}

	func resolve() throws -> [any Collection<Room.ID>] {
		// var paths: [Path] = []

		let startRoom = try map.room(map.bound.start)

		guard !startRoom.tubes.isEmpty else { throw ResolvingError.noPath }

		let nextRoomToLook = try map.adjacentsRoom(to: startRoom.id)

		dump(nextRoomToLook)
		// TODO

		return []
	}

}
