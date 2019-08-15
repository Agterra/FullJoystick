//
//  FullJoyStick.swift
//  ArcClicker
//
//  Created by Agterra on 14/08/2019.
//  Copyright © 2019 Agterra's app. All rights reserved.
//

import SpriteKit

enum FullJoystickType: String {
    case moving
    case orientating
}

class FullJoystick: SKNode {
    private var targetNode: SKNode!
    private var anchorView: SKSpriteNode!
    private var joystickView: SKSpriteNode!
    private var fullJoystickType: FullJoystickType!
    private let joystickRadius: CGFloat = 32.0
    override var isUserInteractionEnabled: Bool {
        get {
            return true
        }
        set {
            // Not set
        }
    }

    init(targetNode: SKNode, fullJoystickType: FullJoystickType = .moving) {
        self.targetNode = targetNode
        self.fullJoystickType = fullJoystickType

        super.init()

        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented with storyboard")
    }

    private func setupView() {
        self.anchorView = SKSpriteNode(texture: SKTexture(image: UIImage(named: "joystickanchor1")!),
                                       size: CGSize(width: joystickRadius * 2,
                                                    height: joystickRadius * 2))

        self.joystickView = SKSpriteNode(texture: SKTexture(image: UIImage(named: "joystick1")!),
                                         size: CGSize(width: joystickRadius * 2,
                                                      height: joystickRadius * 2))
        
        self.addChild(anchorView)
        self.addChild(joystickView)
    }

    override func touchesMoved(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        var position = touch.location(in: self)
        let distance = sqrt(pow(position.x, 2) + pow(position.y, 2))
        if distance > self.joystickRadius {
            position = CGPoint(x: position.x / distance * self.joystickRadius,
                               y: position.y / distance * self.joystickRadius)
            self.joystickView.position = position
        } else {
            self.joystickView.position = position
        }
        let targetPoint = self.targetNode?.position.applying(CGAffineTransform(translationX: position.x,
                                                                                  y: position.y))
        self.targetNode?.position = targetPoint!
    }
    
    override func touchesEnded(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.joystickView.position = self.anchorView.position
    }

    public var velocity: CGPoint {
        let difference = self.joystickRadius * 2 * 0.02
        return CGPoint(x: self.joystickView.position.x / difference,
                       y: self.joystickView.position.y / difference)
    }

    public var angular: CGFloat {
        let velocity = self.velocity
        return atan2(velocity.x, velocity.y)
    }
}

