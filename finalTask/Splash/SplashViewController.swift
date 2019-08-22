//
//  SplashViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/22.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

// スプラッシュ参考サイト  https://qiita.com/eKushida/items/a3304e00347681f51e2d
// https://qiita.com/k-boy/items/7de88a834bf01a6e858f

import UIKit

class SplashViewController: UIViewController {

    // イメージビューと紐付け。TwitterLikeImageViewにすることで動きを加える
    @IBOutlet weak var rogoImage: TwitterLikeImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // イメージびゅーをアニメーションさせる
    override func viewDidAppear(_ animated: Bool) {
        rogoImage.startSplashAnimation()
        self.toTimeLine()
    }

    // タイムラインへ遷移するメソッド。認証成功時に組み込む
    func toTimeLine(){
        // storyboardのfileの特定
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // 移動先のncをインスタンス化。ナビゲーションバーを表示させるために無理やり作ってる
        let nc = storyboard.instantiateInitialViewController() as! UINavigationController
        self.present(nc, animated: true)
    }
}

// イメージビューにアニメーションを加えるためのクラス追加
class TwitterLikeImageView: UIImageView, TwitterLikeAnimation {}

/// ツイッターと同じスプラッシュ画面にするメソッド
protocol TwitterLikeAnimation {}

extension TwitterLikeAnimation where Self: UIImageView {

    func startSplashAnimation() {

        let timing = UICubicTimingParameters(animationCurve: .easeOut)
        let animator = UIViewPropertyAnimator(duration: 0.7, timingParameters: timing)

        animator.addAnimations{
            self.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        }

        animator.addAnimations({
            self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.alpha = 0
        }, delayFactor: 0.8)

        animator.addCompletion { (position) in
            self.removeFromSuperview()
        }
        animator.startAnimation()
    }
}


