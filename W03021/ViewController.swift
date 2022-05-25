//
//  ViewController.swift
//  W03021
//
//  Created by mikka on 2022/05/25.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var anserImageView: UIImageView!
    @IBOutlet weak var anserLabel: UILabel!
    
    var jankenponPlayer:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 音を鳴らすための処理
        let audioPath = Bundle.main.path(forResource: "jankenpon", ofType: "mp3")!
        let jankenponUrl = URL(fileURLWithPath: audioPath)
        do {
            jankenponPlayer = try AVAudioPlayer(contentsOf: jankenponUrl)
        } catch let error as NSError {
            print(error.code)
        }
        
        jankenponPlayer.delegate = self // 自分自身（このアプリ）
    }

    // じゃんけんの手のランダムの初期値
    var newAnserNumber:UInt32 = 0
    // じゃんけんの一つ前の手を格納する変数
    var preAnserNumber:UInt32 = 4
    @IBAction func btnClick(_ sender: Any) {
        jankenponPlayer.play() // 再生

    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // 音がなり終わってからの処理
        // じゃんけんの手をランダムで出す
        // 画像を設定
        
        newAnserNumber=arc4random_uniform(3)
        while newAnserNumber == preAnserNumber {
            // 一つ前の手と同じならばもう一度振り直す
            newAnserNumber=arc4random_uniform(3)
        }
        // 今出した手を一つ前の手とする
        preAnserNumber=newAnserNumber
        switch (newAnserNumber){
        case 0:
            anserImageView.image=UIImage(named: "gu")
            anserLabel.text="グー"
        case 1:
            anserImageView.image=UIImage(named: "choki")
            anserLabel.text="チョキ"
        case 2:
            anserImageView.image=UIImage(named: "pa")
            anserLabel.text="パー"
        default:
            break
        }
    }
    
}

