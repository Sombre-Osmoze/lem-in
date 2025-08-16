///
///
///

class Engine {
	let map: Map
	let ants: Set<Ant>
	let solver: any Solver

	enum SolvingError: Error {
		case unSolvable
	}

	init(map: Map, ants: Set<Ant>) throws {
		self.ants = ants
		self.map = map
		self.solver = try Self.determine(map: map, ants: ants)
	}

	static func determine(map: Map, ants: Set<Ant>) throws -> any Solver {
		guard ants.count > 1 else {
			return SolverSingle(map: map, ants: ants)
		}

		throw SolvingError.unSolvable
	}

	func run(in renderer: any Renderer) throws {
		renderer.configure()

		// Resolve paths
		try solver.resolve()

	}

}
