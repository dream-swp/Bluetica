import XCTest

@testable import Bluetica
@testable import CoreBluetooth

struct Model: Identifiable {
    var id: UUID
    var name: String?

}

final class BlueticaTests: XCTestCase {

    var s: CBManagerState = .unknown

    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods

//        var bluetica = Bluetica.default
//        let _ =
//            bluetica.updateState { manager, central in
//                self.s = central.state
//            }
//            .central.options { (["": 1]) }
//            .central.options {
//                (["": 1])
//            }
//        
//
    }

}
