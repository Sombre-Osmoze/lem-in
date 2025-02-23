class Map {
    let rooms: Set<Room>
    let bound: (start: Room.ID, end: Room.ID)

    init(rooms: Set<Room>, start: Room, end: Room) {
        self.rooms = rooms
        self.bound = (start: start.id, end: end.id)
    }
}
