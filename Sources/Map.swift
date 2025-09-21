// Map logics

class Map {

    enum RoomError: Error {
        case notFound(_ id: Room.ID)
    }

    let rooms: Set<Room>
    let bound: (start: Room.ID, end: Room.ID)

    init(rooms: Set<Room>, start: Room, end: Room) {
        self.rooms = rooms
        self.bound = (start: start.id, end: end.id)
    }

    func room(_ id: Room.ID) throws -> Room {
        guard let room = rooms.first(where: { $0.id == id }) else {
            throw RoomError.notFound(id)
        }
        return room
    }

    func adjacentsRoom(to roomID: Room.ID) throws -> Set<Room.ID> {
        let fromRoom = try room(roomID)

        return fromRoom.tubes
    }
}
