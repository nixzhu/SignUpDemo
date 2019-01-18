import UIKit

class SignUpViewController: UIViewController {
    private lazy var core = SignUpCore(
        updatedState: { state in
            self.doneBarButtonItem.isEnabled = state == .passed
            switch state {
            case .normal:
                self.promptContainerView.isHidden = true
            case .passwordNotMatch:
                self.promptContainerView.isHidden = false
                self.promptLabel.text = "Password Not Match"
            case .passed:
                self.promptContainerView.isHidden = true
            }
            print("state:", state)
        }
    )

    @IBOutlet private weak var doneBarButtonItem: UIBarButtonItem!

    @IBOutlet private weak var promptContainerView: UIView!
    @IBOutlet private weak var promptLabel: UILabel!

    @IBOutlet private weak var nicknameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmedPasswordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        core.viewDidLoad()

        nicknameTextField.addTarget(self, action: #selector(textDidChanged(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChanged(_:)), for: .editingChanged)
        confirmedPasswordTextField.addTarget(self, action: #selector(textDidChanged(_:)), for: .editingChanged)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        nicknameTextField.becomeFirstResponder()
    }

    @objc private func textDidChanged(_ sender: UITextField) {
        switch sender {
        case nicknameTextField:
            core.nicknameDidChanged(sender.text)
        case passwordTextField:
            core.passwordDidChanged(sender.text)
        case confirmedPasswordTextField:
            core.comfirmedPasswordDidChanged(sender.text)
        default:
            break
        }
    }
}
