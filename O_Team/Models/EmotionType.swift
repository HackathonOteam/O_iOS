//
//  EmotionType.swift
//  O_Team
//
//  Created by SangWoo's MacBook on 2023/06/11.
//

import UIKit

enum EmotionType: String {
    case AngryEmotion = "화나요"
    case BadEmotion = "좋지 않아요"
    case SadEmotion = "슬퍼요"
    case BoringEmotion = "지루해요"
    case ExcitedEmotion = "신나요"
    case SickEmotion = "아파요"
    case FineEmotion = "괜찮아요"
    case HappyEmotion = "즐거워요"
    case SuprisedEmotion = "놀랐어요"
    
    var text: String {
        switch self {
        case .BadEmotion: return "평범했네요"
        case .AngryEmotion: return "조금 좋지 않았네요"
        case .BoringEmotion: return "따분한 일이 많으셨나봐요"
        case .FineEmotion: return "힘들지만 잘 이겨냈어요!"
        case .SuprisedEmotion: return "놀랄만한 일이 많으셨나봐요"
        case .ExcitedEmotion: return "즐거운 달이었네요 :)"
        case .SadEmotion: return "힘든 일이 많았어요"
        case .SickEmotion: return "많이 아팠어요"
        case .HappyEmotion: return "많이 웃으셨네요!"
        }
    }
    
    var image: UIImage {
        switch self {
        case .BadEmotion: return UIImage(named: "BadEmotion") ?? UIImage()
        case .AngryEmotion: return UIImage(named: "AngryEmotion") ?? UIImage()
        case .BoringEmotion: return UIImage(named: "BoringEmotion") ?? UIImage()
        case .FineEmotion: return UIImage(named: "FineEmotion") ?? UIImage()
        case .SuprisedEmotion: return UIImage(named: "SuprisedEmotion") ?? UIImage()
        case .ExcitedEmotion: return UIImage(named: "ExcitedEmotion") ?? UIImage()
        case .SadEmotion: return UIImage(named: "SadEmotion") ?? UIImage()
        case .SickEmotion: return UIImage(named: "SickEmotion") ?? UIImage()
        case .HappyEmotion: return UIImage(named: "HappyEmotion") ?? UIImage()
        }
    }
}
