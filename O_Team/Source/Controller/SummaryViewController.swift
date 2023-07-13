import UIKit

final class SummaryViewController: UIViewController {
    private let backgroundView = UIView().then {
        $0.backgroundColor = .subLighten
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "요약중이에요\n잠시만 기다려주세요."
        $0.numberOfLines = 0
        $0.font = .pretendard(.medium, size: 24)
        $0.textColor = .white
    }
    
    private let frameView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = .init(width: 0, height: 2)
        $0.layer.cornerRadius = 8
    }
    
    private let emotionImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "HappyEmotion")?.withRenderingMode(.alwaysOriginal)
    }
    
    private let dateLabel = UILabel().then {
        $0.font = .pretendard(.bold, size: 16)
        $0.textColor = .mainTextColor
        $0.text = "날짜"
    }
    
    private let contentLabel = UILabel().then {
        $0.text = "임시 내용"
        $0.textColor = .subGrayColor
        $0.font = .pretendard(.regular, size: 16)
        $0.numberOfLines = 3
    }
    
    private let continueButton = UIButton(type: .system).then {
        $0.setTitle("대화 계속하기", for: .normal)
        $0.backgroundColor = .clear
        $0.setTitleColor(.activeBlueColor, for: .normal)
        $0.layer.borderColor = UIColor.activeBlueColor.cgColor
        $0.layer.borderWidth = 1.5
        $0.layer.cornerRadius = 8
    }
    
    private let goHomeButton = UIButton(type: .system).then {
        $0.setTitle("홈으로 돌아가기", for: .normal)
        $0.backgroundColor = .activeBlueColor
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 8
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        let userName = UserDefaults.standard.string(forKey: "key") ?? ""
        
        SummaryService.getSummary(userName) { response in
            print(response.emotion)
            let emotion = response.emotion.filter{ $0.isLetter } + "Effect"
            self.emotionImageView.image = UIImage(named: emotion)
            self.contentLabel.text = response.summary
            
            let components = response.date.split(separator: ".")
            let date = components[0] + "년 " + components[1] + "월 " + components[2] + "일"
            self.dateLabel.text = date
            self.titleLabel.text = "\(userName)님,\n\(components[1] + "월 " + components[2])" + "일 기록에 대한 요약이에요."
            self.title = components[1] + "월 " + components[2] + "일의 기록"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addSubView()
        self.layout()
        
        self.continueButton.addTarget(self, action: #selector(didClickContinueButton), for: .touchUpInside)
        self.goHomeButton.addTarget(self, action: #selector(didClickGoHomeButton), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func didClickContinueButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didClickGoHomeButton() {
        self.navigationController?.dismiss(animated: true)
    }
    
    private func addSubView() {
        self.view.addSubview(self.backgroundView)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.frameView)
        
        self.view.addSubview(self.continueButton)
        self.view.addSubview(self.goHomeButton)
        
        self.frameView.addSubview(self.emotionImageView)
        self.frameView.addSubview(self.dateLabel)
        self.frameView.addSubview(self.contentLabel)
    }
    
    private func layout() {
        self.backgroundView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(self.frameView.snp.top).offset(60)
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(24)
        }
        
        self.frameView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(35)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(400)
        }
        
        self.emotionImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(38)
            $0.height.equalTo(190)
        }
        
        self.contentLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        self.dateLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(self.contentLabel.snp.top).offset(-6)
        }
        
        self.goHomeButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().offset(-40)
        }
        
        self.continueButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(52)
            $0.bottom.equalTo(self.goHomeButton.snp.top).offset(-8)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
