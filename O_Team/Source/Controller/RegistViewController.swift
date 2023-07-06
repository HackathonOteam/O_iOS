import UIKit
import SnapKit
import Gifu

final class RegistViewController: UIViewController {
    private let Requestregister = UserService()
    
    private let titleLabel = UILabel().then {
        $0.font = .pretendard(.bold, size: 24)
        $0.numberOfLines = 2
        $0.text = "타래에 오신 걸 환영해요!\n성함이 어떻게 되시나요?"
        $0.textAlignment = .center
    }
    
    private let nameInputTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "성함을 입력해주세요.",attributes: [ .font : UIFont.pretendard(.regular, size: 12),
                                                                                          .foregroundColor : UIColor.subGrayColor])
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        $0.leftViewMode = .always
        $0.backgroundColor = .backGroundColor
        $0.layer.cornerRadius = 8
    }
    
    private let completeButton = UIButton(type: .system).then {
        $0.setTitle("입력완료", for: .normal)
        $0.titleLabel?.font = .pretendard(.bold, size: 16)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .activeBlueColor
    }
    
    private let gifImageView = GIFImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.addSubView()
        self.layout()
        
        gifImageView.prepareForAnimation(withGIFNamed: "sample5")
        gifImageView.animate(withGIFNamed: "sample5")
        
        self.nameInputTextField.delegate = self
    }
    
    private func addSubView() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(nameInputTextField)
        self.view.addSubview(gifImageView)
        self.view.addSubview(completeButton)
        
        completeButton.addTarget(self, action: #selector(didClickCompletionButton), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func layout() {
        self.titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(88)
        }
        
        self.gifImageView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(70)
            $0.leading.trailing.equalToSuperview().inset(80)
            $0.height.equalTo(140)
        }
        
        self.nameInputTextField.snp.makeConstraints {
            $0.top.equalTo(self.gifImageView.snp.bottom).offset(100)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
        
        self.completeButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-24)
            $0.height.equalTo(52)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    @objc private func didClickCompletionButton() {
        if let text = self.nameInputTextField.text,
           text != "" {
            Requestregister.PostJoin(userName: text) { UserResponse in
                UserDefaults.standard.setValue(text, forKey: "key")
                self.dismiss(animated: true)
            }
        } else {
            print("Error")
        }
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

extension RegistViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let range = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: range, with: string)
            
            if !updatedText.isEmpty {
                completeButton.isEnabled = true
                completeButton.backgroundColor = .activeBlueColor
            } else {
                completeButton.isEnabled = false
                completeButton.backgroundColor = .gray
            }
        }
        
        return true
    }
}
