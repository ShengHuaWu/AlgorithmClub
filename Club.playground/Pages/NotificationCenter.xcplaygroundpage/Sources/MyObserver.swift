public protocol MyObserver: AnyObject {
    func receive(_ notification: String)
}
