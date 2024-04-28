public extension String {

    var firstCharCapitalized: String {
        prefix(1).capitalized + dropFirst()
    }
}
