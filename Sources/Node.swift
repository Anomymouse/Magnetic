//
//  Node.swift
//  Magnetic
//
//  Created by Lasha Efremidze on 3/25/17.
//  Copyright © 2017 efremidze. All rights reserved.
//

import SpriteKit

open class Node: SKShapeNode {
    
    lazy var mask: SKCropNode = { [unowned self] in
        let node = SKCropNode()
        node.maskNode = {
            let node = SKShapeNode(circleOfRadius: self.frame.width / 2)
            node.fillColor = .black
            node.strokeColor = .clear
            return node
        }()
        self.addChild(node)
        return node
    }()
    
    open lazy var label: SKLabelNode = { [unowned self] in
        let label = SKLabelNode(fontNamed: "Avenir-Black")
        label.fontSize = 12
        label.verticalAlignmentMode = .center
        self.mask.addChild(label)
        return label
    }()
    
    open lazy var sprite: SKSpriteNode = { [unowned self] in
        let sprite = SKSpriteNode()
        sprite.size = self.frame.size
        sprite.colorBlendFactor = 0.5
        self.mask.addChild(sprite)
        return sprite
    }()
    
    open var title: String? {
        get { return label.text }
        set { label.text = newValue }
    }
    
    open var image: UIImage? {
        didSet {
            guard let image = image else { return }
            texture = SKTexture(image: image)
        }
    }
    
    open var color: UIColor {
        get { return sprite.color }
        set { sprite.color = newValue }
    }
    
    var texture: SKTexture!
    
    open var selected: Bool = false {
        didSet {
            guard selected != oldValue else { return }
            if selected {
                run(SKAction.scale(to: 4/3, duration: 0.2))
                sprite.run(SKAction.setTexture(texture))
            } else {
                run(SKAction.scale(to: 1, duration: 0.2))
                sprite.texture = nil
            }
        }
    }
    
    open class func make(title: String?, image: UIImage?, radius: CGFloat, color: UIColor) -> Node {
        let node = Node(circleOfRadius: radius)
        node.physicsBody = {
            let body = SKPhysicsBody(circleOfRadius: radius + 2)
            body.allowsRotation = false
            body.friction = 0
            body.linearDamping = 2
            return body
        }()
        node.fillColor = .black
        node.strokeColor = .clear
        _ = node.sprite
        _ = node.title
        node.title = title
        node.image = image
        node.color = color
        return node
    }
    
}
