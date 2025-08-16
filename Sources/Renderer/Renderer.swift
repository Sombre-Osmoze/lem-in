protocol Renderer {

	associatedtype Path = [Room.ID]

	init(_ engine: Engine)

	func configure()
}
