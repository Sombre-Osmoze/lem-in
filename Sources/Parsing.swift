enum ParsingError: Error {
    case noRoomStart
    case incorrectLine
    case noStartRoom
    case noEndRoom

}

func parsing(_ text: String) throws -> (map: Map, ants: Int) {
    /// TODO: File verification

    let lines = text.split(separator: "\n")

    let antsCount = Int(lines.first!)!
    logger.info("Ants count: \(antsCount)")

    var startMakerIndex: Int? = nil
    var endMakerIndex: Int? = nil
    var startRoomID: Room.ID? = nil
    var endRoomID: Room.ID? = nil

    var linkData: [(from: Room.ID, to: Room.ID)] = []
    var roomData: [(id: Room.ID, coordinates: Room.Coordinates)] = []

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

        case let roomText where roomText.count { $0 == " " } == 2:

            let parts = roomText.split(separator: " ")
            let roomId = String(parts[0])
            let coordinates = SIMD2(x: Int(parts[1])!, y: Int(parts[2])!)
            roomData.append((id: roomId, coordinates: coordinates))
            if let startMakerIndex, index == startMakerIndex + 1 {
                startRoomID = roomId
            } else if let endMakerIndex, index == endMakerIndex + 1 {
                endRoomID = roomId
            }
        case let tubeText where tubeText.count { $0 == "-" } == 1:
            let parts = tubeText.split(separator: "-")
            linkData.append((from: String(parts[0]), to: String(parts[1])))
        default:
            logger.error("incorrect line: \(line)")
            throw ParsingError.incorrectLine
        }
    }

    let rooms = roomData.map { data in
        var tubes: [Room.ID] = []
        let linkArriving = linkData.filter { (from, to) in to == data.id }.map(\.from)
        tubes.append(contentsOf: linkArriving)
        let linkDeparting = linkData.filter { (from, to) in from == data.id }.map(\.to)
        tubes.append(contentsOf: linkDeparting)
        return Room(data.id, coordinates: data.coordinates, tubes: Set(tubes))
    }

    guard let startRoomID, let startRoom = rooms.first(where: { $0.id == startRoomID }) else {
        throw ParsingError.noStartRoom
    }
    guard let endRoomID, let endRoom = rooms.first(where: { $0.id == endRoomID }) else {
        throw ParsingError.noStartRoom
    }

    return (map: .init(rooms: .init(rooms), start: startRoom, end: endRoom), ants: antsCount)
}
