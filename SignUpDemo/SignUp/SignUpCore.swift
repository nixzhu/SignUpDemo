import Foundation

class SignUpCore {
    private var nickname: String?
    private var password: String?
    private var confirmedPassword: String?

    enum State: Equatable {
        case normal
        case passwordNotMatch
        case passed
    }

    private var state: State = .normal {
        didSet {
            updatedState(state)
        }
    }

    private let updatedState: (State) -> Void

    init(updatedState: @escaping (State) -> Void) {
        self.updatedState = updatedState
    }

    func viewDidLoad() {
        updatedState(state)
    }

    func nicknameDidChanged(_ newNickname: String?) {
        nickname = newNickname
        state = checkState()
    }

    func passwordDidChanged(_ newPassword: String?) {
        password = newPassword
        state = checkState()
    }

    func comfirmedPasswordDidChanged(_ newComfirmedPassword: String?) {
        confirmedPassword = newComfirmedPassword
        state = checkState()
    }

    private func checkState() -> State {
        guard let nickname = nickname, !nickname.isEmpty else { return .normal }
        guard let password = password, !password.isEmpty else { return .normal }
        guard let confirmedPassword = confirmedPassword, !confirmedPassword.isEmpty else { return .normal }

        if password.count == confirmedPassword.count {
            if password == confirmedPassword {
                return .passed
            } else {
                return .passwordNotMatch
            }
        } else {
            return .normal
        }
    }
}
