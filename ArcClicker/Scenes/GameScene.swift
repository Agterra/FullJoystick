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
    private var movementJoystick: FullJoystick!
    private var rotationJoystick: FullJoystick!
    private var movementAndRotationJoystick: FullJoystick!
    private var element: SKSpriteNode!

    override func didMove(to view: SKView) {
        self.backgroundColor = .white
        super.didMove(to: view)

        self.element = SKSpriteNode(texture: SKTexture(image: UIImage(named: "tank")!),
                                    size: CGSize(width: 50.0,
                                                 height: 50.0))
        self.element.speed = 0.1

        self.movementJoystick = FullJoystick(targetNode: self.element,
                                             fullJoystickType: .movement)
        self.rotationJoystick = FullJoystick(targetNode: self.element,
                                             fullJoystickType: .rotation)

        self.movementAndRotationJoystick = FullJoystick(targetNode: self.element,
                                                        fullJoystickType: .movementAndRotation)
        self.movementAndRotationJoystick.joystickColor = .lightGray
        self.movementAndRotationJoystick.anchorColor = .gray

        self.addChild(movementJoystick)
        self.addChild(rotationJoystick)
        self.addChild(movementAndRotationJoystick)
        self.addChild(element)

        movementAndRotationJoystick.position = CGPoint(x: (self.view?.bounds.midX)!,
                                                       y: (self.view?.bounds.minY)! + 100.0)

        movementJoystick.position = CGPoint(x: (self.view?.bounds.minX)! + 50.0,
                                            y: (self.view?.bounds.minY)! + 100.0)

        rotationJoystick.position = CGPoint(x: (self.view?.bounds.maxX)! - 50.0,
                                            y: (self.view?.bounds.minY)! + 100.0)

        element.position = CGPoint(x: (self.view?.bounds.midX)!,
                                   y: (self.view?.bounds.midY)!)
    }
}
