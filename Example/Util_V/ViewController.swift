//
//  ViewController.swift
//  Util
//
//  Created by V on 02/21/2023.
//  Copyright (c) 2023 V. All rights reserved.
//

import UIKit
import Util_V

class ViewController: UIViewController {
    
    var delegates = DelegateCenter<UtilDelegate>()
    
    struct FileDemoModel: Codable { }
    
    @JSONFile<[FileDemoModel]>(defaultValue: [], fileName: "test")
    var file
    
    @UserDefaultsBacked<Bool?>(wrappedValue: nil, key: "test")
    var test
    
    @UserDefaultsBacked(wrappedValue: nil, key: "5")
    var test2: Bool?
    
    @UserDefaultsBacked(key: "4")
    var test1: Bool? = nil
    
    
    private lazy var button: UIButton = {
        let button = UIButton(title: "test", titleColor: .blue, font: .systemFont(ofSize: 16, weight: .semibold))
        button.addTarget(self, action: #selector(Tap), for: .touchUpInside)
        return button
    }()
    
    @objc private func Tap() {
        localizedStringDemo()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(button)
        button.frame = view.frame
        
    }
}

//MARK: --- NSLocalizedString ----
extension ViewController {
    func localizedStringDemo() {
        Bundle.setLanguage("zh-Hant")
        print(__("a"))
        print(Util.appLanguage)
    }
}

//MARK: --- JSONFile ----
extension ViewController {
    func JSONFileDemo() {
        _file.save()
    }
}

//MARK: --- TabBarController ----
extension ViewController {
    func tabBarDemo() {
        let vc = UIViewController()
        
        let item = DefaultBaseTabbarItemView()
        item.setImage(nil, state: .normal)
        item.setTitle("1", state: .normal)
        item.setTextColor(.blue, state: .normal)
        item.setTextColor(.black, state: .selected)
        item.setFont(.systemFont(ofSize: 12))
        
        let tab = BaseTabBarViewController(controllers: [vc], tabItems: [item])
        tab.selectedIndex = 0
    }
}

//MARK: --- NavigationController ----
extension ViewController {
    func naviagtionDemo() {
        let vc = UIViewController()
        //设置统一返回键
        let nac = BaseNavigationController(rootViewController: vc, backImage: UIImage(named: "icon_return"))
        
        navigationBar.changedTranslucent(isTranslucent: true)
        
        navigationBar.setTintColor(color: .black)
        
        navigationBar.setBackground(image: UIColor.red.image(CGSize(width: 1, height: 1)), color: .red)
        
        navigationBar.setShadow(image: UIColor.blue.image(CGSize(width: 1, height: 1)), color: .blue)
    }
}

//MARK: --- Transitioning ----
extension ViewController {
    func interactiveDemo() {
        let vc = UIViewController()
        vc.view.backgroundColor = .random
        self.swipePresent(vc: vc, animated: true)
    }
    
    func presentDemo() {
        let vc = PresentDemoViewController()
        self.present(vc: vc, direction: .right, edgeInsets: .init(top: 0, left: 0, bottom: 0, right: 20), modalPresentationStyle: .custom, animated: true)
    }
}

//MARK: --- GradientView ----
extension ViewController {
    func gradinetDemo() {
        let gap = GradientGap.init(leftTop: 5, rightTop: 3, leftBottom: 2, rightBottom: 1)
        let direction = GradientDirection.custom(CGPoint(x: 0.2, y: 0.5), CGPoint(x: 0.8, y: 0.5))
        
        //四边形
        let quadrilateral = GradientViewOfQuadrilateral(direction: direction, gap: gap)
        
        let button = GradientViewOfButton(direction: direction)
        
        let text = GradientViewOfText(direction: direction)
    }
}

//MARK: --- HotZone ----
extension ViewController {
    func hotZoneDemo() {
        let button = HotZoneButton()
        button.hotZoneEdgeInsets = .zero
    }
}

//MARK: --- MultipleDelegates ----
protocol UtilDelegate: AnyObject { }
extension ViewController: UtilDelegate {
    func multipleDelegatesDemo() {
        delegates.add(self)
        
        delegates.call {
            $0
        }
        
        delegates.remove(self)
    }
}

//MARK: --- system ----
extension ViewController {
    func appTrackingDemo() {
        AppTrackingManager().setup(self)
        /*
         info
         <key>NSUserTrackingUsageDescription</key>
             <string>Your data will be used to provide better personalized services, please rest assured that we will not leak your privacy.</string>
         
         一次权限文案
         
         NSUserTrackingUsageDescription = "This identifier will be used to deliver personalized ads to you.";
         
         NSUserTrackingUsageDescription = "该标识符将用于向您投放个性化广告。";
         
         NSUserTrackingUsageDescription = "この識別子は、パーソナライズされた広告を配信するために使用されます。。";
         
         NSUserTrackingUsageDescription = "該標識符將用於向您投放個性化廣告。";
         
         NSUserTrackingUsageDescription = "이 식별자는 개인 맞춤 광고를 제공하는 데 사용됩니다.";
         */
    }
    
    func mailFeedbackDemo() {
        MailFeedbackManager().openMail(from: self, recipient: ["123"])
    }
    
    func authorizationDemo() {
        checkAVCaptureAuthorization(parent: self,
                                    for: .audio,
                                    title: "1",
                                    message: "2",
                                    cancel: "3",
                                    confirm: "4") {
            
        }
        
        checkPhotoAuthorization(parent: self,
                                title: "1",
                                message: "2",
                                cancel: "3",
                                confirm: "4") {
            
        }
    }
    
    func deviceFeedbackDemo() {
        let url = URL(string: "123")!
        
        DeviceFeedbackManager.vibrationFeedback()
        
        DeviceFeedbackManager.voiceFeedback(scoure: url)
        
        DeviceFeedbackManager.voiceAndVibrationFeedback(scoure: url)
    }
}
