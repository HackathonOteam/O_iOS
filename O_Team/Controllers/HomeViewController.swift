//
//  HomeViewController.swift
//  O_Team
//
//  Created by SangWoo's MacBook on 2023/06/10.
//

import UIKit
import SnapKit
import Then

final class HomeViewController: UIViewController {
    //MARK: - Properties
    private let topBackgroundView = UIView().then {
        $0.backgroundColor = .subLighten
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "똴랄라뚤랄라님,\n기억해야 할 것들을\n알려드릴게요."
        $0.font = .pretendard(.medium, size: 20)
        $0.textColor = .white
        $0.numberOfLines = 0
    }
    
    private let titleImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 87/2
        $0.layer.masksToBounds = true
        $0.image = UIImage(named: "FineEmotion")
    }
    
    private let memoryCardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(MemoryCardCell.self, forCellWithReuseIdentifier: MemoryCardCell.identifier)
        let layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubView()
        self.layout()
        self.configureVC()
        
        self.memoryCardCollectionView.delegate = self
        self.memoryCardCollectionView.dataSource = self
    }
    
    //MARK: - Configure
    private func configureVC() {
        self.view.backgroundColor = .white
        self.title = "도담"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white,
                                                                        .font : UIFont.pretendard(.bold, size: 16)]
    }
    
    //MARK: - addSubView
    private func addSubView() {
        self.view.addSubview(self.topBackgroundView)
        self.view.addSubview(self.memoryCardCollectionView)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.titleImageView)
    }
    
    //MARK: - Layout
    private func layout() {
        self.titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(14)
        }
        
        self.titleImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-24)
            $0.centerY.equalTo(self.titleLabel.snp.centerY)
            $0.width.height.equalTo(87)
        }
        
        self.memoryCardCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(46)
            $0.trailing.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(400)
        }
        
        self.topBackgroundView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(self.memoryCardCollectionView.snp.top).offset(54)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: 24, height: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .init(width: 24, height: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemoryCardCell.identifier, for: indexPath) as! MemoryCardCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width - 48, height: 400)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let cellWidthIncludingSpacing = self.view.frame.width - 48 + 12
        
        let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing
        let index: Int
        
        if velocity.x > 0 {
            index = Int(ceil(estimatedIndex))
        } else if velocity.x < 0 {
            index = Int(floor(estimatedIndex))
        } else {
            index = Int(round(estimatedIndex))
        }
    
        targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing, y: 0)
    }
}
