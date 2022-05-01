import Foundation

public struct Frame {
    let origin: (x: Int, y: Int)
    let size: (width: Int, height: Int)
    
    public init(origin: (Int, Int), size: (Int, Int)) {
        self.origin = origin
        self.size = size
    }
}

public struct View {
    let name: String
    let frame: Frame
    let subviews: [View]
    
    public init(name: String, frame: Frame, subviews: [View] = []) {
        self.name = name
        self.frame = frame
        self.subviews = subviews
    }
}

extension View: CustomStringConvertible {
    public var description: String {
        "<View: \(name)> <frame: \(frame)>"
    }
}

extension View {
    // The key point here is defining `prefix` and `level`
    // and increasing them in the next iteration of recursion
    public func recursiveDescription() -> String {
        recursiveDescription(prefix: "", level: 0)
    }
    
    private func recursiveDescription(prefix: String, level: Int) -> String {
        if subviews.isEmpty {
            return prefix + description
        }
        
        var newPrefix = "\n"
        for _ in 0...level {
            newPrefix += "|  "
        }
        
        var newResult = ""
        for view in subviews {
            newResult += view.recursiveDescription(prefix: newPrefix, level: level + 1)
        }
        
        return prefix + description + newResult
    }
}
