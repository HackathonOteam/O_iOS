import UIKit
import DGCharts
import SnapKit
import Charts

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
    var emotionaldateLabel: UILabel!
    var welcomeemotionalLabel: UILabel!
    var userNickname: UILabel!
    var welcomeComment: UILabel!
    var pieChartView: PieChartView!

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
        emotionaldateLabel = UILabel()
        emotionaldateLabel.textColor = UIColor(red: 0.775, green: 0.773, blue: 0.773, alpha: 1)
        emotionaldateLabel.font =  UIFont(name: "Pretendard-Bold", size: 16)
        emotionaldateLabel.text = "2023년 6월의 감정 분석 카드"
        emotionanalyzeView.addSubview(emotionaldateLabel)
        emotionaldateLabel.snp.makeConstraints{ make in
            make.top.equalTo(emotionanalyzeView.snp.top).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.width.equalTo(295)
            make.height.equalTo(26)
        }
        userNickname = UILabel()
        userNickname.textColor = UIColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 1)
        userNickname.font =  UIFont(name: "Pretendard-Bold", size: 24)
        userNickname.text = "마늘보다갈릭님"
        userNickname.sizeToFit()
        emotionanalyzeView.addSubview(userNickname)
        userNickname.snp.makeConstraints{ make in
            make.top.equalTo(emotionaldateLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(40)
        }
        welcomeemotionalLabel = UILabel()
        welcomeemotionalLabel.textColor = UIColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 1)
        welcomeemotionalLabel.font =  UIFont(name: "Pretendard-Bold", size: 24)
        welcomeemotionalLabel.text = "은 이번달에"
        emotionanalyzeView.addSubview(welcomeemotionalLabel)
        welcomeemotionalLabel.snp.makeConstraints{ make in
            make.top.equalTo(emotionaldateLabel.snp.bottom).offset(12)
            make.left.equalTo(userNickname.snp.right).offset(0) // 닉네임 라벨의 오른쪽에 위치하도록 설정
            make.height.equalTo(40)
        }
        welcomeComment = UILabel()
        welcomeComment = UILabel()
        welcomeComment.textColor = UIColor(red: 0.77, green: 0.84, blue: 0.241, alpha: 1)
        welcomeComment.font =  UIFont(name: "Pretendard-Bold", size: 24)
        welcomeComment.text = "많이 웃으셨네요!"
        welcomeComment.sizeToFit()
        emotionanalyzeView.addSubview(welcomeComment)
        welcomeComment.snp.makeConstraints{ make in
            make.top.equalTo(userNickname.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(40)
        }
        
        pieChartView = PieChartView(frame: CGRect(x: 0, y: 0, width: 260, height: 260))
         /*pieChartView.center = view.center
         view.addSubview(pieChartView)*/
        emotionanalyzeView.addSubview(pieChartView)
        pieChartView.snp.makeConstraints{
            $0.top.equalTo(welcomeComment.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(41)
            $0.right.equalToSuperview().offset(-41)
            $0.bottom.equalToSuperview().offset(31)

        }
        func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage {
            let size = image.size

            let widthRatio  = targetSize.width  / size.width
            let heightRatio = targetSize.height / size.height

            let scaleFactor = min(widthRatio, heightRatio)

            let newSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
            let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: newSize)

            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
            image.draw(in: rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return newImage ?? UIImage()
        }
        let iconSize = CGSize(width: 30, height: 30) // 원하는 아이콘 크기로 설정

        if let originalImage = UIImage(named: "HappyEmotion") {
            let resizedImage = resizeImage(originalImage, targetSize: iconSize)
            let icon = NSUIImage(cgImage: resizedImage.cgImage!, scale: resizedImage.scale, orientation: resizedImage.imageOrientation)
            let a = PieChartDataEntry(value: 43,label:"", icon: icon)
            
            let entries = [
                PieChartDataEntry(value: 43,label:"행복", icon: icon),
                PieChartDataEntry(value: 7, label: "우울"),
                PieChartDataEntry(value: 50, label: "기타"),
                // 나머지 항목들은 비율을 조절하여 케이크 모양에 맞게 설정
            ]

            let dataSet = PieChartDataSet(entries: entries, label: "")
            let colors: [NSUIColor] = [
                NSUIColor(red: 0.302, green: 0.329, blue: 0.945, alpha: 1),
                NSUIColor(red: 0.655, green: 0.668, blue: 0.962, alpha: 1),
                NSUIColor(red: 0.784, green: 0.793, blue: 0.983, alpha: 1)
            ]
            dataSet.colors = colors
            dataSet.drawIconsEnabled = true
            dataSet.iconsOffset = CGPoint(x: 0, y: -35)
            dataSet.valueLinePart1OffsetPercentage = 1.2 // Value Label을 아이콘에서 떨어뜨릴 비율을 크게 조정
            dataSet.valueLinePart1Length = 0.0 // Value Label 선 길이를 0으로 설정하여 선을 표시하지 않음

            // Value Label 텍스트 설정
            dataSet.valueTextColor = .white
            dataSet.valueFont = UIFont(name: "Pretendard-Bold", size: 15)!
             let data = PieChartData(dataSet: dataSet)
             pieChartView.data = data
             pieChartView.drawHoleEnabled = false
            
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
