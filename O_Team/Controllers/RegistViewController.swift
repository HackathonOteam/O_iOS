//
//  RegistViewController.swift
//  O_Team
//
//  Created by 드즈 on 2023/06/11.
//

import UIKit
import SnapKit
import Gifu

class RegistViewController: UIViewController {
    let textField = UITextField()
    let completeButton = UIButton()
    let label = UILabel()
    let line = CALayer()
    let gifImageView = GIFImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupUI()
        setupConstraints()
        gifImageView.prepareForAnimation(withGIFNamed: "sample")
        gifImageView.animate(withGIFNamed: "sample")
    }
    
    private func setupUI() {
        label.numberOfLines = 2
        label.text = "앱이름에 오신 걸 환영해요!\n성함이 어떻게 되세요!"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        view.addSubview(label)
        
        //gifImageView.contentMode = .scaleAspectFit
        view.addSubview(gifImageView)
        
        
        textField.placeholder = "성함을 입력해주세요"
        textField.backgroundColor = UIColor.blue.withAlphaComponent(0.1).resolvedColor(with: UIScreen.main.traitCollection)//textField.backgroundColor = UIColor.blue.withAlphaComponent(0.1)
        textField.layer.cornerRadius = 10.0
        textField.layer.borderColor = UIColor.blue.cgColor
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always

        textField.delegate = self
        view.addSubview(textField)
        
        completeButton.setTitle("입력완료", for: .normal)
        completeButton.setTitleColor(.white, for: .normal)
        completeButton.layer.cornerRadius = 10.0
        completeButton.backgroundColor = UIColor.blue.withAlphaComponent(0.7)
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        view.addSubview(completeButton)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupConstraints() {
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(88)
        }
        
        gifImageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(81)
            $0.top.equalToSuperview().offset(234)
            $0.width.equalTo(203)
            $0.height.equalTo(141)
        }
        
        textField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(494)
            $0.width.equalTo(327)
            $0.height.equalTo(52)
        }
        
        completeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-72)
            $0.width.equalTo(327)
            $0.height.equalTo(52)
        }
    }
    
    @objc private func completeButtonTapped() {
        // let nextViewController = NextViewController()
        // nextViewController.name = name
        // navigationController?.pushViewController(nextViewController, animated: true)
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
                completeButton.backgroundColor = .blue
            } else {
                completeButton.isEnabled = false
                completeButton.backgroundColor = .gray
            }
        }
        return true
    }
}


