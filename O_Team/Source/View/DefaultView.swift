//
//  DefaultView.swift
//  O_Team
//
//  Created by 신상우 on 2023/07/14.
//

import UIKit
import Gifu

final class DefaultView: UIView {
    private let frameView = UIView().then {
        $0.backgroundColor = .backGroundColor
        $0.layer.cornerRadius = 8
    }
    
    private let gifView = GIFImageView()
    
    private let guideLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.text = "기록이 아직 없어요!\n기록을 하면 카드 형태로\n리마인드를 보여드려요."
        $0.textColor = .subGrayColor
        $0.font = .pretendard(.regular, size: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        gifView.prepareForAnimation(withGIFNamed: "defaultG")
        gifView.animate(withGIFNamed: "defaultG")
        
        self.addSubview(self.frameView)
        self.frameView.addSubview(self.gifView)
        self.frameView.addSubview(self.guideLabel)
        
        self.frameView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        self.gifView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(140)
            $0.height.equalTo(170)
        }
        
        self.guideLabel.snp.makeConstraints {
            $0.top.equalTo(self.gifView.snp.bottom).offset(58)
            $0.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
