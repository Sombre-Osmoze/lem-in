import Foundation

struct Ant: Identifiable, Hashable {
	typealias ID = String
	let id: String

	static func generate(_ count: Int) -> Set<Ant> {
		return .init(
			(1...count).map { index in
				Ant(id: "L\(index)")
			})
	}
}
