func parsing(_ text: String) {

    /// TODO: File verification

    let lines = text.split(separator: "\n")

    let antsCount = Int(lines.first!)!
    logger.info("Ants count: \(antsCount)")

    for line in lines.dropFirst() {

        if line == "##start" {
            print("Line: \(line)")
        } else if line.hasPrefix("#") {
            print(line)
        } else {
            // TODO parse
            print("Code: \(line)")
        }
    }
}
