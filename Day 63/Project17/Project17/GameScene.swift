//
//  GameScene.swift
//  Project17
//
//  Created by Martin Kabát on 16.11.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var starField: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var enemyLabel: SKLabelNode!
    var newGameButton: SKLabelNode!
    var lastPlayerPosition: CGPoint?
    var enemyCount = 0 {
        didSet {
            enemyLabel.text = "Enemies: \(enemyCount)"
            if enemyCount > 20 {
                gameTimer?.invalidate()
                gameTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
            } else if enemyCount > 40 {
                gameTimer?.invalidate()
                gameTimer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
            } else if enemyCount > 60 {
                gameTimer?.invalidate()
                gameTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
            }
        }
    }
    
    var possibleEnemies = ["ball", "hammer", "tv"]
    var gameTimer: Timer?
    var isGameOver = false {
        didSet {
            if isGameOver {
                newGameButton.isHidden = false
                gameTimer?.invalidate()
            }
        }
    }
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score \(score)"
        }
    }
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        starField = SKEmitterNode(fileNamed: "starfield")
        starField.position = CGPoint(x: 1024, y: 384)
        starField.advanceSimulationTime(10) //in seconds
        addChild(starField)
        starField.zPosition = -1 // behind all things
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 50)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        score = 0
        
        enemyLabel = SKLabelNode(fontNamed: "Chalkduster")
        enemyLabel.position = CGPoint(x: frame.maxX - 16, y: 50)
        enemyLabel.horizontalAlignmentMode = .right
        addChild(enemyLabel)
        
        enemyCount = 0
        
        newGameButton = SKLabelNode(fontNamed: "Chalkduster")
        newGameButton.position = CGPoint(x: frame.midX, y: frame.midY) // middle of the screen
        newGameButton.horizontalAlignmentMode = .center
        newGameButton.text = "New Game"
        newGameButton.isHidden = true
        newGameButton.name = "New Game"
        newGameButton.zPosition = 2
        addChild(newGameButton)
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
    }
    
    @objc func createEnemy() {
        guard let enemy = possibleEnemies.randomElement() else { return }
        
        enemyCount += 1
        
        let sprite = SKSpriteNode(imageNamed: enemy)
        sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
        addChild(sprite)
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0) // will make enemy move left
        sprite.physicsBody?.angularVelocity = 5 // makes it rotate
        sprite.physicsBody?.linearDamping = 0 // will never slows down
        sprite.physicsBody?.angularDamping = 0 // will never stop spinning
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }
        
        if !isGameOver {
            score += 1
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        var location = touch.location(in: self)
        
        if location.y < 100 {
            location.y = 100
        } else if location.y > 668 {
            location.y = 668
        }
        
        player.position = location
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let explosion = SKEmitterNode(fileNamed: "explosion")!
        explosion.position = player.position
        addChild(explosion)
        
        player.removeFromParent()
        isGameOver = true
    }
    
    func startNewGame() {
        newGameButton.isHidden = true
        player.position = CGPoint(x: 100, y: 384)
        addChild(player)
        score = 0
        enemyCount = 0
        isGameOver = false
        gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        let frontTouchNode = atPoint(location).name
        if frontTouchNode == "New Game" {
            startNewGame()
            return
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }

        let location = touch.location(in: self)
        
        player.position = CGPoint(x: 100, y: frame.midY) // suck it, cheater
    }
}
