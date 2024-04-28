import SwiftUI

public enum DeviceType {
    case iPhone
    case iPad
}

public extension View {
    
    var isiPhone: Bool {
        switch device {
        case .iPhone:
            true
        case .iPad:
            false
        }
    }
    
    var device: DeviceType {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
                .iPhone
        case .pad:
                .iPad
        default:
                .iPhone
        }
    }
}
