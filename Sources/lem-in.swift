import ArgumentParser
import Foundation
import Logging

nonisolated(unsafe) var logger = Logger(label: "lem-in")

@main
struct Lemin: ParsableCommand {

    @Option(name: .shortAndLong, help: "Use a path to a file instead of standard input")
    var file: String? = nil

    enum Error: Swift.Error {
        case invalidFile
        case invalidText

    }

    mutating func run() throws {
        logger.logLevel = .info

        if let file = file {  // If file is provided
            guard let data = FileManager.default.contents(atPath: file) else {
                logger.error("Error reading file")
                throw Error.invalidFile
            }

            guard let text = String(data: data, encoding: .utf8) else {
                logger.error("Error decoding file")
                throw Error.invalidText
            }

            let (map, antCount) = try parsing(text)
            try process(map, antCount)
        } else {
            // Fall back to standard input
            let file = FileHandle.standardInput
            guard let data = try file.readToEnd() else {
                logger.error("Error reading from standard input")
                throw Error.invalidFile
            }
            guard let text = String(data: data, encoding: .utf8) else {
                logger.error("Error decoding standard input")
                throw Error.invalidText
            }
            let (map, antCount) = try parsing(text)
            try process(map, antCount)
        }

        func process(_ map: Map, _ antCount: Int) throws {
            let ants = Ant.generate(antCount)
            logger.info("generated \(ants.count) ants")

            let engine = try Engine(map: map, ants: ants)
            let renderer = RendererText(engine)

            try engine.run(in: renderer)
        }
    }
}
