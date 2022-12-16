//
//  GameScene.swift
//  Project17
//
//  Created by Martin Kabát on 16.11.2022.
//

import SpriteKit
import GameplayKit
import GameController

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
            if enemyCount > 20 && enemyCount < 40 {
                gameTimer?.invalidate()
                gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
            } else if enemyCount > 40 && enemyCount < 60  {
                gameTimer?.invalidate()
                gameTimer = Timer.scheduledTimer(timeInterval: 0.65, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
            } else if enemyCount > 60 && enemyCount < 80  {
                gameTimer?.invalidate()
                gameTimer = Timer.scheduledTimer(timeInterval: 0.55, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
            } else if enemyCount > 80 && enemyCount < 100  {
                gameTimer?.invalidate()
                gameTimer = Timer.scheduledTimer(timeInterval: 0.45, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
            } else if enemyCount > 100 && enemyCount < 120  {
                gameTimer?.invalidate()
                gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
            } else if enemyCount > 120 && enemyCount < 140  {
                gameTimer?.invalidate()
                gameTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
            }  else if enemyCount > 140 && enemyCount < 160  {
                gameTimer?.invalidate()
                gameTimer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
            } else if enemyCount > 160 {
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
        observeForGameControllers() // Add game controller support
        
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
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.85, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
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
        gameTimer = Timer.scheduledTimer(timeInterval: 0.85, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
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
    
    // Add game controller support
    func observeForGameControllers() {
        NotificationCenter.default.addObserver(self, selector: #selector(connectControllers), name: NSNotification.Name.GCControllerDidConnect, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(disconnectControllers), name: NSNotification.Name.GCControllerDidDisconnect, object: nil)
    }
    
    // This Function is called when a controller is connected to the Apple TV
    @objc func connectControllers() {
        //Unpause the Game if it is currently paused
        self.isPaused = false
        
        //Used to register the Nimbus Controllers to a specific Player Number
        var indexNumber = 0
        
        // Run through each controller currently connected to the system
        for controller in GCController.controllers() {
            
            //Check to see whether it is an extended Game Controller (Such as a Nimbus)
            if controller.extendedGamepad != nil {
                controller.playerIndex = GCControllerPlayerIndex.init(rawValue: indexNumber)!
                indexNumber += 1
                setupControllerControls(controller: controller)
            }
        }
    }
    
    // Function called when a controller is disconnected from the Apple TV
    @objc func disconnectControllers() {
        
        // Pause the Game if a controller is disconnected ~ This is mandated by Apple
        self.isPaused = true
    }
    
    func setupControllerControls(controller: GCController) {
        
        //Function that check the controller when anything is moved or pressed on it
        controller.extendedGamepad?.valueChangedHandler = { (gamepad: GCExtendedGamepad, element: GCControllerElement) in
            
            // Add movement in here for sprites of the controllers
            self.controllerInputDetected(gamepad: gamepad, element: element, index: controller.playerIndex.rawValue)
        }
    }
    
    
    func controllerInputDetected(gamepad: GCExtendedGamepad, element: GCControllerElement, index: Int) {
        if (gamepad.leftThumbstick == element) {
            if (gamepad.leftThumbstick.xAxis.value != 0) {
                print("Controller: \(index), LeftThumbstickXAxis: \(gamepad.leftThumbstick.xAxis)")
                player.position = CGPoint(x: player.position.x + CGFloat(20*gamepad.leftThumbstick.xAxis.value), y: player.position.y )
                
            } else if (gamepad.leftThumbstick.xAxis.value == 0) {
                // YOU CAN PUT CODE HERE TO STOP YOUR PLAYER FROM MOVING
            }
            
            if (gamepad.leftThumbstick.yAxis.value != 0) {
                print("Controller: \(index), LeftThumbstickYAxis: \(gamepad.leftThumbstick.yAxis)")
                player.position = CGPoint(x: player.position.x, y: player.position.y + CGFloat(20*gamepad.leftThumbstick.yAxis.value))
            } else if (gamepad.leftThumbstick.yAxis.value == 0) {
                // YOU CAN PUT CODE HERE TO STOP YOUR PLAYER FROM MOVING
            }
        }
        
        // Right Thumbstick
        if (gamepad.rightThumbstick == element) {
            if (gamepad.rightThumbstick.xAxis.value != 0)
            {
                print("Controller: \(index), rightThumbstickXAxis: \(gamepad.rightThumbstick.xAxis)")
            }
        }
        // D-pad
        else if (gamepad.dpad == element) {
            if (gamepad.dpad.xAxis.value != 0)
            {
                print("Controller: \(index), D-PadXAxis: \(gamepad.rightThumbstick.xAxis)")
            } else if (gamepad.dpad.xAxis.value == 0) {
                // YOU CAN PUT CODE HERE TO STOP YOUR PLAYER FROM MOVING
            }
        }
        
        // A-button
        else if (gamepad.buttonA == element) {
            if (gamepad.buttonA.value != 0) {
                print("Controller: \(index), A-Button Pressed!")
                
                // Restart game
                if isGameOver {
                    startNewGame()
                }
            }
        }
        
        // B-button
        else if (gamepad.buttonB == element){
            if (gamepad.buttonB.value != 0) {
                print("Controller: \(index), B-Button Pressed!")
            }
        }
        
        // Y-button
        else if (gamepad.buttonY == element) {
            if (gamepad.buttonY.value != 0)
            {
                print("Controller: \(index), Y-Button Pressed!")
            }
        }
        
        // X-button
        else if (gamepad.buttonX == element) {
            if (gamepad.buttonX.value != 0) {
                print("Controller: \(index), X-Button Pressed!")
            }
        }
    }
}
