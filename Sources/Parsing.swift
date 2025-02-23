enum ParsingError: Error {
    case noRoomStart
    case incorrectLine
    case noStartRoom
    case noEndRoom

}

func parsing(_ text: String) throws -> Map {

    /// TODO: File verification

    let lines = text.split(separator: "\n")

    let antsCount = Int(lines.first!)!
    logger.info("Ants count: \(antsCount)")

    var rooms = Set<Room>()
    var startMakerIndex: Int? = nil
    var endMakerIndex: Int? = nil
    var startRoom: Room? = nil
    var endRoom: Room? = nil

    for (index, line) in lines.dropFirst().enumerated() {

        switch line {
        case let startMaker where startMaker == "##start":
            logger.debug("start maker index: \(index)")
            startMakerIndex = index
        case let endMaker where endMaker == "##end":
            logger.debug("end maker index: \(index)")
            endMakerIndex = index

        case let comment where comment.hasPrefix("#"):  // Printing comments
            print(comment)
            continue

        case let roomData where roomData.count { $0 == " " } == 2:
            let room = Room(from: roomData)
            logger.debug("room parsed(line: \(index + 1): \(room.id)")
            rooms.insert(room)

            if let startMakerIndex, index == startMakerIndex - 1 {
                startRoom = room
            } else if let endMakerIndex, index == endMakerIndex - 1 {
                endRoom = room
            }
        case let tubeData where tubeData.count { $0 == "-" } == 1:
            continue
        default:
            logger.error("incorrect line: \(line)")
            throw ParsingError.incorrectLine
        }
    }

    guard let startRoom else {
        logger.error("no start room")
        throw ParsingError.noStartRoom
    }
    guard let endRoom else {
        logger.error("no end room")
        throw ParsingError.noEndRoom
    }

    return .init(rooms: rooms, start: startRoom, end: endRoom)
}
