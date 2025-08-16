final class RendererText: Renderer {
	let engine: Engine

	init(_ engine: Engine) {
		self.engine = engine
	}

	func configure() {
		print(engine.ants.count)
	}
}
