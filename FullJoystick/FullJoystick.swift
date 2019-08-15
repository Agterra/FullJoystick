//
//  FullJoyStick.swift
//  ArcClicker
//
//  Created by Agterra on 14/08/2019.
//  Copyright © 2019 Agterra's app. All rights reserved.
//

import SpriteKit

enum FullJoystickType: String {
    case movement
    case rotation
    case movementAndRotation
}

class FullJoystick: SKNode {
    private let targetNode: SKNode!
    private let fullJoystickType: FullJoystickType
    private let joystickDiameter: CGFloat
    private let anchorDiameter: CGFloat
    private var anchorView: SKSpriteNode!
    private var joystickView: SKSpriteNode!
    public var joystickColor: UIColor? {
        didSet {
            guard let color = joystickColor else {
                return
            }
            let scale = UIScreen.main.scale
            let needSize = CGSize(width: joystickDiameter,
                                  height: joystickDiameter)

            UIGraphicsBeginImageContextWithOptions(needSize,
                                                   false,
                                                   scale)
            let rectanglePath = UIBezierPath(ovalIn: CGRect(origin: .zero,
                                                            size: needSize))
            rectanglePath.addClip()
            color.set()
            rectanglePath.fill()

            let textureImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()

            self.joystickView.texture = SKTexture(image: textureImage)
        }
    }
    public var anchorColor: UIColor? {
        didSet {
            guard let color = anchorColor else {
                return
            }
            let scale = UIScreen.main.scale
            let needSize = CGSize(width: anchorDiameter,
                                  height: anchorDiameter)

            UIGraphicsBeginImageContextWithOptions(needSize,
                                                   false,
                                                   scale)
            let rectanglePath = UIBezierPath(ovalIn: CGRect(origin: .zero,
                                                            size: needSize))
            rectanglePath.addClip()
            color.set()
            rectanglePath.fill()

            let textureImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()

            self.anchorView.texture = SKTexture(image: textureImage)
        }
    }

    init(targetNode: SKNode,
         fullJoystickType: FullJoystickType = .movement) {
        self.targetNode = targetNode
        self.fullJoystickType = fullJoystickType
        self.joystickDiameter = 60.0
        self.anchorDiameter = 30.0

        super.init()

        self.isUserInteractionEnabled = true
        self.setupView()
    }

    init(targetNode: SKNode,
         fullJoystickType: FullJoystickType = .movement,
         joystickDiameter: CGFloat,
         anchorDiameter: CGFloat) {
        self.joystickDiameter = joystickDiameter
        self.anchorDiameter = anchorDiameter
        self.targetNode = targetNode
        self.fullJoystickType = fullJoystickType

        super.init()

        self.isUserInteractionEnabled = true
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented with storyboard")
    }

    private func setupView() {
        self.anchorView = SKSpriteNode(texture: SKTexture(image: UIImage(named: "joystickanchor1")!),
                                       size: CGSize(width: anchorDiameter,
                                                    height: anchorDiameter))

        self.joystickView = SKSpriteNode(texture: SKTexture(image: UIImage(named: "joystick1")!),
                                         size: CGSize(width: joystickDiameter,
                                                      height: joystickDiameter))

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
        if distance > self.joystickDiameter {
            position = CGPoint(x: position.x / distance * self.joystickDiameter,
                               y: position.y / distance * self.joystickDiameter)
            self.joystickView.position = position
        } else {
            self.joystickView.position = position
        }

        switch self.fullJoystickType {
        case .movement:
            self.moveTargetNode(position: position)
        case .rotation:
            self.rotateTargetNode(position: position)
        case .movementAndRotation:
            self.moveTargetNode(position: position)
            self.rotateTargetNode(position: position)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.joystickView.position = self.anchorView.position
    }

    private func moveTargetNode(position: CGPoint) {
        let transform = CGAffineTransform(translationX: position.x * self.targetNode.speed,
                                          y: position.y * self.targetNode.speed)
        let targetPoint = self.targetNode?.position.applying(transform)
        self.targetNode?.position = targetPoint!
    }

    private func rotateTargetNode(position: CGPoint) {
        let rotation = -atan2(position.x, position.y)
        self.targetNode.zRotation = rotation
    }
}
