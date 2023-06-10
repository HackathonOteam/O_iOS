import UIKit
import SnapKit

class MonthCalendarViewController: UIViewController {
    var scrollView: UIScrollView!
    var contentView: UIView!
    var calendarView: UIView!
    var emotionanalyzeView: UIView!
    var collectionview: UICollectionView!
    var dateview:UIView!
    var dateLabel:UILabel!
    var dateleftButton: UIButton!
    var daterightButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
        setCollectionView()
    }
    
    func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // 세로 스크롤 방향 설정
        collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.backgroundColor = .clear
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(EmotionCollectionViewCell.self, forCellWithReuseIdentifier: "EmotionCollectionViewCell")
        dateview.addSubview(collectionview)
        collectionview.snp.makeConstraints { make in
            make.top.equalTo(dateview.snp.bottom).offset(33)
            make.left.equalTo(dateview.snp.left).offset(0)
            make.right.equalTo(dateview.snp.right).offset(0)
            make.height.equalTo(320)
        }
    }



    
    func setConfigure() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .BackGroundColor
        navigationBarAppearance.configureWithTransparentBackground()
        navigationBarAppearance.shadowImage = UIImage()

        navigationController!.navigationBar.standardAppearance = navigationBarAppearance
        navigationController!.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        self.view.backgroundColor = .BackGroundColor
        self.navigationItem.title = "이번달감정"
        //스크롤뷰 생서
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top) // safeAreaLayoutGuide의 top과 일치
            make.left.right.bottom.equalToSuperview() // 왼쪽, 오른쪽, 아래쪽에 대한 제약 조건은 슈퍼뷰와 일치
        }
        
        // 컨텐트 뷰 생성
        contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(0)
            make.width.equalToSuperview().offset(0)// 컨텐트 뷰의 너비를 스크롤 뷰와 같게 설정
            make.height.equalTo(1104) // 컨텐트 뷰의 높이를 네비게이션바 아래부터 1104로 설정
        }
        
        calendarView = UIView()
        calendarView.backgroundColor = .mainColor
        contentView.addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.height.equalTo(465) // 추가 뷰의 높이 설정
        }
        emotionanalyzeView = UIView()
        emotionanalyzeView.backgroundColor = .white
        emotionanalyzeView.layer.cornerRadius = 8
        contentView.addSubview(emotionanalyzeView)
        emotionanalyzeView.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(-30)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(440)
        }
        dateview = UIView()
        dateview.backgroundColor = .DeepPurple
        dateview.layer.cornerRadius = 8
        calendarView.addSubview(dateview)
        dateview.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(44)
        }
        dateLabel = UILabel()
        dateLabel.text = "2023년 6월의 기록"
        dateLabel.textColor = .white
        dateLabel.textAlignment = .center // 텍스트를 가운데 정렬
        //dateLabel.backgroundColor = .red
        dateview.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(28)
        }
        dateleftButton = UIButton()
       // daterightButton = UIButton()
        dateleftButton.tintColor = .white
        dateleftButton.setImage(UIImage(named:"arrow"), for: .normal)
        dateview.addSubview(dateleftButton)
        dateleftButton.snp.makeConstraints{ make in
            make.right.equalTo(dateLabel.snp.left).offset(-44)
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(13.5)
            make.bottom.equalToSuperview().offset(-13.5)
            make.width.equalTo(7) // 버튼의 너비 설정
            make.height.equalTo(17) // 버튼의 높이 설정
        }
        daterightButton = UIButton()
       // daterightButton = UIButton()
        daterightButton.tintColor = .white
        daterightButton.setImage(UIImage(named:"rightarrow"), for: .normal)
        dateview.addSubview(daterightButton)
        daterightButton.snp.makeConstraints{ make in
            make.left.equalTo(dateLabel.snp.right).offset(44)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(13.5)
            make.bottom.equalToSuperview().offset(-13.5)
            make.width.equalTo(7) // 버튼의 너비 설정
            make.height.equalTo(17) // 버튼의 높이 설정
        }
        let menuImage = UIImage(systemName:"line.3.horizontal")
        // 오른쪽 버튼에 메뉴 이미지 설정
        let rightButton = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(buttonTapped))
        rightButton.tintColor = .black
        navigationItem.rightBarButtonItem = rightButton
  

    }
    
    @objc func buttonTapped() {
        print("ㅁㄴㅇㅁㅇㄴ")
    }
}
extension MonthCalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionview.dequeueReusableCell(withReuseIdentifier: "EmotionCollectionViewCell", for: indexPath) as? EmotionCollectionViewCell else {return UICollectionViewCell()}
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width - 5) / 6 // 셀의 너비를 컬렉션뷰의 너비로 나눈 값으로 설정 (여기서는 3개의 셀을 한 줄에 배치하고 간격을 16으로 설정)
        let cellHeight: CGFloat = 78 // 셀의 높이 설정
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}
