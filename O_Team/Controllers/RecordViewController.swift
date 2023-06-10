//
//  RecordViewController.swift
//  O_Team
//
//  Created by SangWoo's MacBook on 2023/06/11.
//

import UIKit
import Speech

final class RecordViewController: UIViewController {
    //MARK: - Properties
    private let isPresentType: Bool
    private var dataArray: [String] = ["오늘 일어났던 일들 중에서 기억에 가장 많이 남는 일은 어떤 것인가요?","오늘 일어났던 일들 중에서 기억에 가장 많이 남는 일은 어떤 것인가요?","오늘 일어났던 일들 중에서 기억에 가장 많이 남는 일은 어떤 것인가요?"]
    
    private let speechRecognizer = SFSpeechRecognizer(locale: .init(identifier: "ko-KR")) // 한국말 Recognizer 생성
    
    //음성인식요청을 처리하는 객체
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    //음성 인식 요청 결과를 제공하는 객체)
    private var recognitionTask: SFSpeechRecognitionTask?
    // 소리를 인식하는 오디오 엔진 객체
    private let audioEngine = AVAudioEngine()

    private let contentTableView = UITableView().then {
        $0.register(RecordCell.self, forCellReuseIdentifier: RecordCell.identifier)
        $0.backgroundColor = .subLighten
        $0.separatorStyle = .none
    }
    
    private let recordButton = UIButton(type: .system).then {
        $0.backgroundColor = .activeBlueColor
        $0.setImage(UIImage(named: "mike"), for: .normal)
        $0.layer.cornerRadius = 8
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        $0.tintColor = .white
    }
    
    init(isPresentType: Bool) {
        self.isPresentType = isPresentType
        super.init(nibName: nil, bundle: nil)
        if isPresentType  {
            let item = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(self.dismissVC))
            item.tintColor = .subGrayColor
            
            self.navigationItem.leftBarButtonItem = item
        }
        
        let item = UIBarButtonItem(title: "기록 완료", style: .done, target: self, action: #selector(self.didClickDoneButton))
        item.tintColor = UIColor(red: 255/255, green: 127/255, blue: 127/255, alpha: 1)
        self.navigationItem.rightBarButtonItem = item
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "6월 10일의 기록"
        
        self.addSubView()
        self.layout()
        
        self.contentTableView.delegate = self
        self.contentTableView.dataSource = self
        self.speechRecognizer?.delegate = self
        
        self.recordButton.addTarget(self, action: #selector(didClickRecordButton), for: .touchUpInside)
    }
    
    @objc private func dismissVC() {
        self.dismiss(animated: true)
    }
    
    @objc private func didClickDoneButton() {
        print("didClickDoneButton")
    }
    
    @objc private func didClickRecordButton() {
        if self.audioEngine.isRunning { // 현재 음성인식이 수행중이면
            self.audioEngine.stop() // 오디오 인식 중지
            self.recognitionRequest?.endAudio() // 음성인식도 중지
            self.recordButton.setImage(UIImage(named: "mike"), for: .normal)
        
        }else { //현재 음성인식이 수행중이지 않으면
            self.startRecoding() // 음성인식 시작)
            self.recordButton.setImage(UIImage(named: "pause"), for: .normal)
            
        }
    }
    
    private func addSubView() {
        self.view.addSubview(self.contentTableView)
        self.view.addSubview(self.recordButton)
    }
    
    private func layout() {
        self.contentTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.recordButton.snp.top).offset(-12)
        }
        
        self.recordButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-40)
            $0.trailing.equalToSuperview().offset(-24)
            $0.width.equalTo(72)
            $0.height.equalTo(50)
        }
    }
}

extension RecordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.dataArray.count == 1 {
            let view = UIView()
            return view
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.dataArray.count == 1 {
            return 400
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecordCell.identifier, for: indexPath) as! RecordCell
        cell.prepareForReuse()
        
        if indexPath.row == self.dataArray.count-1 {
            cell.questionLabel.font = .pretendard(.bold, size: 28)
            cell.questionLabel.alpha = 1
            cell.answerLabel.alpha = 1
        }
        
        return cell
    }
}

extension RecordViewController: SFSpeechRecognizerDelegate {
    func startRecoding(){
        //이전 인식 결과 리셋
        if self.recognitionTask != nil {
            self.recognitionTask?.cancel()
            self.recognitionTask = nil
        }
        
        //오디오 녹음을 준비할 객체 ( 단순히 정말 소리만 인식하는 객체임)
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            // 세션을 녹음 범주 , 측정 모드 , 활성화 설정
            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch(let e) { //오류 처리
            print(e.localizedDescription)
        }
        // 음성인식을 요청하는 객체 생성
        self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        // 오디오 입력노드 변수
        let inputNode = self.audioEngine.inputNode
        
        guard let recognitionRequest = self.recognitionRequest else {
            fatalError("No Request Instance")
            return
        }
        
        //말할 때 부분적인 결과를 보고하도록 함
        recognitionRequest.shouldReportPartialResults = true
        
        //음성 인식중에 세련되거나,최소 정지 한 때에 결과를 반환해주는 Handler
        self.recognitionTask = self.speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            guard let result else {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
                return
            }
                
            isFinal = result.isFinal //최종이면 true 중간결과면 false
            
            
            //오류이거나 최종 결과인경우 오디오 중지
            if isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
                let text = result.bestTranscription.formattedString
                self.dataArray.append(text)
                self.contentTableView.reloadData()
            }
        })
        
        //recognitionRequest에 오디오 입력을 추가
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
               
        self.audioEngine.prepare()
               
        do {
            try self.audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
    }
}
