class SolverSingle: Solver {

	enum ResolvingError: Error {
		case noPath
	}

	private let map: Map

	init(map: Map, ants: Set<Ant>) {
		self.map = map
	}

	var path: (any Path)? = nil

	func resolve() throws -> [any Collection<Room.ID>] {
		// For one ant we use BreadthFirst Search to find the shortest path
		let paths: [any Collection<Room.ID>] = try BreathFirstSearchAll.search(in: map)

		let shortest = paths.min { rhs, lhs in
			rhs.count > lhs.count
		}

		guard let shortest else { throw ResolvingError.noPath }

		path = shortest

		return [shortest]
	}

}
