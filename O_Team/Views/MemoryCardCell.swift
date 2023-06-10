//
//  MemoryCardCell.swift
//  O_Team
//
//  Created by SangWoo's MacBook on 2023/06/10.
//

import UIKit

final class MemoryCardCell: UICollectionViewCell {
    static let identifier = "MemoryCardCell"
    
    //MARK: - Properties
    private let titleLabel = UILabel().then {
        $0.font = .pretendard(.bold, size: 24)
        $0.textColor = .mainTextColor
        $0.text = "제목"
    }
    
    private let imotionImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "HappyEmotion")?.withRenderingMode(.alwaysOriginal)
    }
    
    private let dateLabel = UILabel().then {
        $0.font = .pretendard(.bold, size: 14)
        $0.textColor = .mainTextColor
        $0.text = "날짜"
    }
    
    private let contentLabel = UILabel().then {
        $0.text = "임시 내용"
        $0.textColor = .subGrayColor
        $0.font = .pretendard(.regular, size: 14)
    }
    
    private let moreButton = UIButton().then {
        $0.backgroundColor = .activeBlueColor
        $0.setTitle("더보기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 8
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .init(width: 0, height: 2)
        self.layer.cornerRadius = 8
        
        self.addSubView()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubView() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.imotionImageView)
        self.addSubview(self.dateLabel)
        self.addSubview(self.contentLabel)
        self.addSubview(self.moreButton)
    }
    
    private func layout() {
        self.titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(16)
        }
        
        self.imotionImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(38)
        }
        
        self.moreButton.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        self.contentLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(self.moreButton.snp.top).offset(-16)
        }
        
        self.dateLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(self.contentLabel.snp.top).offset(-6)
        }
    }
}
