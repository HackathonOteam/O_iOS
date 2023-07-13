import UIKit

final class RecordCell: UITableViewCell {
    static let identifier = "RecordCell"
    
    let questionLabel = UILabel().then {
        $0.alpha = 0.5
        $0.textColor = .white
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.text = "오늘 일어났던 일들 중에서 기억에 가장 많이 남는 일은 어떤 것인가요?"
        $0.font = .pretendard(.medium, size: 18)
    }
    
    let backgroundImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.image = UIImage(named: "ChatBackground")
    }
    
    let answerLabel = UILabel().then {
        $0.alpha = 0.5
        $0.textColor = .activeBlueColor
        $0.text = "답변이야."
        $0.numberOfLines = 0
        $0.layer.cornerRadius = 0
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .subLighten
        self.selectionStyle = .none
        
        self.addSubview(questionLabel)
        self.addSubview(backgroundImageView)
        self.addSubview(self.answerLabel)
        
        self.questionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(self.answerLabel.snp.bottom).offset(60)
            $0.bottom.equalToSuperview().offset(-24)
        }
        
        self.answerLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-34)
            $0.leading.equalToSuperview().offset(68)
            $0.top.equalToSuperview().offset(10)
        }
        
        self.backgroundImageView.snp.makeConstraints {
            $0.leading.top.equalTo(self.answerLabel).offset(-10)
            $0.bottom.equalTo(self.answerLabel).offset(10)
            $0.trailing.equalTo(self.answerLabel).offset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.questionLabel.alpha = 0.5
        self.answerLabel.alpha = 0.5
        self.questionLabel.font = .pretendard(.medium, size: 18)
    }
    
    func configureCell(_ model: RecoringModel) {
        if let answer = model.answer,
           !answer.isEmpty {
            self.backgroundImageView.isHidden = false
        } else {
            self.backgroundImageView.isHidden = true
        }
        self.answerLabel.text = model.answer
        self.questionLabel.text = model.question
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
