//
//  GameScene.swift
//  ArcClicker
//
//  Created by Agterra on 13/08/2019.
//  Copyright © 2019 Agterra's app. All rights reserved.
//

import Foundation
import SpriteKit
import FullJoystick

class GameScene: SKScene {
    private var joystick: FullJoystick!
    private var element: SKSpriteNode!

    override var isUserInteractionEnabled: Bool {
        get {
            return true
        }
        set {
            // Not supported
        }
    }

    override func didMove(to view: SKView) {
        self.backgroundColor = .white
        super.didMove(to: view)

        self.element = SKSpriteNode(color: .green,
                                    size: CGSize(width: 25.0,
                                                 height: 25.0))

        self.joystick = FullJoystick(delegate: self)

        self.addChild(joystick)
        self.addChild(element)

        joystick.position = CGPoint(x: (self.view?.bounds.midX)!,
                                    y: (self.view?.bounds.midY)!)
        element.position = CGPoint(x: (self.view?.bounds.midX)!,
                                   y: (self.view?.bounds.midY)!)
    }

    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let position = touch.location(in: self)
        self.joystick.position = position
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.joystick.touchesMoved(touches,
                                   with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.joystick.touchesEnded(touches,
                                   with: event)
    }
}
