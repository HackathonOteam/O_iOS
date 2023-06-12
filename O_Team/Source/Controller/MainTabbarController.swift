import UIKit

final class MainTabbarController: UITabBarController {
    // MARK: - Properties
    private let createDiary = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "Plus"), for: .normal)
        $0.backgroundColor = .activeBlueColor
        $0.tintColor = .white
        $0.layer.cornerRadius = 61/2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.createDiary)
        
        self.createDiary.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(self.tabBar.snp.top)
            $0.width.height.equalTo(61)
        }
        
        self.createDiary.addTarget(self, action: #selector(clickCreateDiaryButton), for: .touchUpInside)
    }
    
    // MARK: - Selctor
    @objc private func clickCreateDiaryButton() {
        let recordVC = UINavigationController(rootViewController: RecordViewController(isPresentType: true))
        recordVC.modalPresentationStyle = .fullScreen
        
        self.present(recordVC, animated: true, completion: { DiaryService.createDiary() })
    }
}
