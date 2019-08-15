//
//  FirstViewController.swift
//  ArcClicker
//
//  Created by Agterra on 13/08/2019.
//  Copyright © 2019 Agterra's app. All rights reserved.
//

import UIKit
import SpriteKit

class MainGameViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let mainView = SKView(frame: self.view.frame)
        self.view.addSubview(mainView)
        let gameScene = GameScene(size: view.bounds.size)
        let transition = SKTransition.doorsOpenHorizontal(withDuration: 10)
        gameScene.scaleMode = .aspectFill
        mainView.presentScene(gameScene,
                              transition: transition)
    }
}
