/// Engine that run solver and proceed to display the move informations.
import Logging

class Engine {
	let map: Map
	let ants: Set<Ant>
	let solver: any Solver
	let logger = Logger(label: "engine")

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
		let paths = try solver.resolve()

		logger.info("found valid path: \(paths.count)")
	}

}
