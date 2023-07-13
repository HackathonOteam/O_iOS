import UIKit
import SnapKit
import Then

final class HomeViewController: UIViewController {
    //MARK: - Properties
    let api = CalendarService()
    var diaryData:[Diary] = []
    let userinfo = UserInfo.shared
    
    private let topBackgroundView = UIView().then {
        $0.backgroundColor = .subLighten
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "사용자님,\n기억해야할 것들을\n알려드릴게요"
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
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        // MARK: API Call Failed
        guard let userName = UserDefaults.standard.string(forKey: "key") else { return }
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateFormatter.locale = .current
        dateFormatter.timeZone = .current

        memoryCardCollectionView.backgroundView = DefaultView()
        self.api.getHomeVideoList(userName: userName, today: dateFormatter.string(from: date)) { DiaryResoponse in
            self.diaryData = []
            
            guard let res = DiaryResoponse else {return}
            if res.anniversaryDiary.date == nil && res.yearAgoDiary.date == nil && res.positiveDiary.date == nil {
            } else {
                self.diaryData.append(res.positiveDiary)
                self.diaryData.append(res.yearAgoDiary)
                self.diaryData.append(res.anniversaryDiary)
            }
            
            self.memoryCardCollectionView.reloadData()
        }
        
        
        self.titleLabel.text = userName + "님,\n기억해야할 것들을\n알려드릴게요"
        let text = self.titleLabel.text ?? ""
        let name = userName + "님,"
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.font, value: UIFont.pretendard(.bold, size: 20), range: (text as NSString).range(of: name))
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white,
                                                                        .font : UIFont.pretendard(.bold, size: 16)]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubView()
        self.layout()
        self.configureVC()
        if UserDefaults.standard.string(forKey: "key") != nil {
            
        } else {
            let vc = RegistViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }

        
        self.memoryCardCollectionView.delegate = self
        self.memoryCardCollectionView.dataSource = self
        self.tabBarController?.delegate = self
    }

    // MARK: - Configure
    private func configureVC() {
        self.view.backgroundColor = .white
        self.title = "타래"
    }
    
    // MARK: - addSubView
    private func addSubView() {
        self.view.addSubview(self.topBackgroundView)
        self.view.addSubview(self.memoryCardCollectionView)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.titleImageView)
    }
    
    
    // MARK: - Layout
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
        return diaryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemoryCardCell.identifier, for: indexPath) as! MemoryCardCell
        
        if indexPath.row == 0 {
            cell.titleLabel.text = "좋았던 기억을 떠올려보세요."
        } else if indexPath.row == 1 {
            cell.titleLabel.text = "1년전 오늘"
        } else {
            cell.titleLabel.text = "누군가의 기념일에 대한\n기록이 있네요!"
        }
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        if let dateString = diaryData[indexPath.row].date,
           let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            let formattedDate = dateFormatter.string(from: date)
            cell.dateLabel.text = formattedDate
            cell.imotionImageView.image = UIImage(named: diaryData[indexPath.row].emotion + "Effect")
        } else {
            cell.imotionImageView.image = UIImage(named: "BoringEmotionEffect")
            cell.dateLabel.text = "기록이 아직 없어요."
        }
        
        
        cell.contentLabel.text = diaryData[indexPath.row].contents
        
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

extension HomeViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return viewController.view.tag == 400 ? false : true
    }
}
