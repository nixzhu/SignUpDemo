import XCTest
@testable import SignUpDemo

class SignUpTests: XCTestCase {
    func testSignUp() {
        var states: [SignUpCore.State] = []

        let core = SignUpCore(
            updatedState: { state in
                states.append(state)
            }
        )

        core.nicknameDidChanged("nixzhu")
        core.passwordDidChanged("abc12")
        core.passwordDidChanged("abc123")
        core.comfirmedPasswordDidChanged("abc124")
        core.comfirmedPasswordDidChanged("abc123")
        core.comfirmedPasswordDidChanged("abc125")
        core.comfirmedPasswordDidChanged(nil)

        let expectedStates: [SignUpCore.State] = [
            .normal,
            .normal,
            .normal,
            .passwordNotMatch,
            .passed,
            .passwordNotMatch,
            .normal
        ]
        XCTAssert(states == expectedStates)
    }
}
