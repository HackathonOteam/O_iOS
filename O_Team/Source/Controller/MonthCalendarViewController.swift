import UIKit
import SnapKit
import DGCharts
import Charts

class MonthCalendarViewController: UIViewController {
    var scrollView: UIScrollView!
    var collectionview: UICollectionView!
    var contentView: UIView!
    var calendarView: UIView!
    var emotionanalyzeView: UIView!
    var dateview: UIView!
    
    var dateLabel: UILabel!
    var emotionaldateLabel: UILabel!
    var welcomeemotionalLabel: UILabel!
    var userNickname: UILabel!
    var welcomeComment: UILabel!
    
    var dateleftButton: UIButton!
    var daterightButton: UIButton!

    var pieChartView: PieChartView!
    let api = CalendarService()
    var count: Int = 0
    var month:DiaryMonthlyResponse = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
        setCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.api.getMonthEmotion(yearMonth: "20XX-XX", userName: "\(String(describing: userNickname))" /*"userNickname"*/) { DiaryMonthResponse in
            // print(DiaryMonthResponse?.count/* as Any*/)
            self.count = Int(DiaryMonthResponse?.count ?? 0)
            self.collectionview.reloadData()
            self.month = DiaryMonthResponse!
        }
    }
    
    func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.backgroundColor = .clear
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(EmotionCollectionViewCell.self, forCellWithReuseIdentifier: "EmotionCollectionViewCell")
        dateview.addSubview(collectionview)
        
        collectionview.snp.makeConstraints {
            $0.top.equalTo(dateview.snp.bottom).offset(33)
            $0.left.equalTo(dateview.snp.left).offset(0)
            $0.right.equalTo(dateview.snp.right).offset(0)
            $0.height.equalTo(320)
        }
    }
    
    func setConfigure() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .backGroundColor
        navigationBarAppearance.configureWithTransparentBackground()
        navigationBarAppearance.shadowImage = UIImage()

        navigationController!.navigationBar.standardAppearance = navigationBarAppearance
        navigationController!.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        self.navigationItem.title = "이번 달 감정"
        self.view.backgroundColor = .backGroundColor
        
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.bottom.equalToSuperview()
        }
        
        contentView = UIView()
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview().offset(0)
            $0.width.equalToSuperview().offset(0)
            $0.height.equalTo(950)
        }
        
        calendarView = UIView()
        calendarView.backgroundColor = .mainColor
        contentView.addSubview(calendarView)
        
        calendarView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(0)
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
            $0.height.equalTo(465)
        }
        
        emotionanalyzeView = UIView()
        emotionanalyzeView.backgroundColor = .white
        emotionanalyzeView.layer.cornerRadius = 8
        contentView.addSubview(emotionanalyzeView)
        
        emotionanalyzeView.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).offset(-30)
            $0.left.equalToSuperview().offset(24)
            $0.right.equalToSuperview().offset(-24)
            $0.height.equalTo(440)
        }
        
        emotionaldateLabel = UILabel()
        emotionaldateLabel.textColor = UIColor(red: 0.775, green: 0.773, blue: 0.773, alpha: 1)
        emotionaldateLabel.font =  UIFont(name: "Pretendard-Bold", size: 16)
        emotionaldateLabel.text = "20XX년 XX월의 감정 분석 카드"
        emotionanalyzeView.addSubview(emotionaldateLabel)
        
        emotionaldateLabel.snp.makeConstraints {
            $0.top.equalTo(emotionanalyzeView.snp.top).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.width.equalTo(295)
            $0.height.equalTo(26)
        }
        
        userNickname = UILabel()
        userNickname.textColor = UIColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 1)
        userNickname.font =  UIFont(name: "Pretendard-Bold", size: 24)
        userNickname.text = "\(String(describing: userNickname))님" /*"userNickname"*/
        userNickname.sizeToFit()
        emotionanalyzeView.addSubview(userNickname)
        
        userNickname.snp.makeConstraints {
            $0.top.equalTo(emotionaldateLabel.snp.bottom).offset(12)
            $0.left.equalToSuperview().offset(16)
            $0.height.equalTo(40)
        }
        
        welcomeemotionalLabel = UILabel()
        welcomeemotionalLabel.textColor = UIColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 1)
        welcomeemotionalLabel.font =  UIFont(name: "Pretendard-Bold", size: 24)
        welcomeemotionalLabel.text = "은 이번달에"
        emotionanalyzeView.addSubview(welcomeemotionalLabel)
        
        welcomeemotionalLabel.snp.makeConstraints {
            $0.top.equalTo(emotionaldateLabel.snp.bottom).offset(12)
            $0.left.equalTo(userNickname.snp.right).offset(0)
            $0.height.equalTo(40)
        }
        
        welcomeComment = UILabel()
        welcomeComment = UILabel()
        welcomeComment.textColor = UIColor(red: 0.77, green: 0.84, blue: 0.241, alpha: 1)
        welcomeComment.font =  UIFont(name: "Pretendard-Bold", size: 24)
        welcomeComment.text = "많이 웃으셨네요!"
        welcomeComment.sizeToFit()
        emotionanalyzeView.addSubview(welcomeComment)
        
        welcomeComment.snp.makeConstraints {
            $0.top.equalTo(userNickname.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(16)
            $0.height.equalTo(40)
        }
        
        pieChartView = PieChartView(frame: CGRect(x: 0, y: 0, width: 260, height: 260))
        // pieChartView.center = view.center
        // view.addSubview(pieChartView)
        emotionanalyzeView.addSubview(pieChartView)
        
        pieChartView.snp.makeConstraints {
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
        
        let iconSize = CGSize(width: 30, height: 30)

        if let originalImage = UIImage(named: "HappyEmotion") {
            let resizedImage = resizeImage(originalImage, targetSize: iconSize)
            let icon = NSUIImage(cgImage: resizedImage.cgImage!, scale: resizedImage.scale, orientation: resizedImage.imageOrientation)
            /*let*/ _ = PieChartDataEntry(value: 43, label: "", icon: icon)
            
            let entries = [
                PieChartDataEntry(value: 43, label:"행복", icon: icon),
                PieChartDataEntry(value: 7, label: "우울"),
                PieChartDataEntry(value: 50, label: "기쁨"),
                // + PieChartDataEntry(value: 50, label: "기타"), ...
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
            dataSet.valueLinePart1OffsetPercentage = 1.2
            dataSet.valueLinePart1Length = 0.0
            
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
        
        dateview.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.left.equalToSuperview().offset(24)
            $0.right.equalToSuperview().offset(-24)
            $0.height.equalTo(44)
        }
        
        dateLabel = UILabel()
        dateLabel.text = "20XX년 XX월의 기록"
        dateLabel.textColor = .white
        dateLabel.textAlignment = .center
        dateview.addSubview(dateLabel)
        // dateLabel.backgroundColor = .red
        
        dateLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(28)
        }
        
        dateleftButton = UIButton()
        dateleftButton.tintColor = .white
        dateleftButton.setImage(UIImage(named:"arrow"), for: .normal)
        dateview.addSubview(dateleftButton)
        
        dateleftButton.snp.makeConstraints {
            $0.right.equalTo(dateLabel.snp.left).offset(-44)
            $0.left.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(13.5)
            $0.bottom.equalToSuperview().offset(-13.5)
            $0.width.equalTo(7)
            $0.height.equalTo(17)
        }
        
        daterightButton = UIButton()
        daterightButton.tintColor = .white
        daterightButton.setImage(UIImage(named:"rightarrow"), for: .normal)
        dateview.addSubview(daterightButton)
        
        daterightButton.snp.makeConstraints {
            $0.left.equalTo(dateLabel.snp.right).offset(44)
            $0.right.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(13.5)
            $0.bottom.equalToSuperview().offset(-13.5)
            $0.width.equalTo(7)
            $0.height.equalTo(17)
        }
        
        let menuImage = UIImage(systemName:"line.3.horizontal")
        let rightButton = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(buttonTapped))
        rightButton.tintColor = .black
        navigationItem.rightBarButtonItem = rightButton
        
    }
    
    @objc func buttonTapped() {
        print("Tap!")
    }
}

extension MonthCalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionview.dequeueReusableCell(withReuseIdentifier: "EmotionCollectionViewCell", for: indexPath) as? EmotionCollectionViewCell else { return UICollectionViewCell() }
        cell.imageView.image = UIImage(named: month[indexPath.row].emotion)
        
        let dateString = month[indexPath.row].date

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MM월 dd일"
            let formattedDate = dateFormatter.string(from: date)
            // print(formattedDate)
            cell.label.text = formattedDate
        } else {
            print("failed Translation")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width - 5) / 6
        let cellHeight: CGFloat = 78
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}
