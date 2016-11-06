import SpriteKit
import EZSwiftExtensions

class GameScene: SKScene {
    var bg: SKSpriteNode!
    var gameSystem: GameSystem!
    var scoreLabel: SKLabelNode!
    var liveIndicator: SKSpriteNode!
    var pauseButton: ButtonNode!
    
    lazy var pauseScreen: SKSpriteNode = {
        let pauseBg = SKSpriteNode(imageNamed: "bg")
        pauseBg.anchorPoint = CGPoint.zero
        var viewCoords = CGPoint(x: 0, y: self.view!.h)
        pauseBg.position = self.view!.convert(viewCoords, to: self)
        pauseBg.zPosition = 2000
        
        let pauseLabel = SKLabelNode(fontNamed: "Copperplate")
        viewCoords = CGPoint(x: self.view!.w / 2, y: self.view!.h / 5)
        pauseLabel.position = pauseBg.convert(self.view!.convert(viewCoords, to: self), from: self)
        pauseLabel.fontSize = 160
        pauseLabel.fontColor = UIColor.white
        pauseLabel.zPosition = 2001
        pauseLabel.text = "PAUSED"
        pauseBg.addChild(pauseLabel)
        
        pauseBg.alpha = 0
        
        return pauseBg
    }()
    
    override func didMove(to view: SKView) {
        view.ignoresSiblingOrder = true
        bg = self.childNode(withName: "bg") as! SKSpriteNode
        
        gameSystem = GameSystem(scene: self)
        
        scoreLabel = SKLabelNode(fontNamed: "Copperplate")
        scoreLabel.position = gameSystem.scoreLabelPosition
        scoreLabel.fontSize = 100
        scoreLabel.fontColor = UIColor.white
        scoreLabel.zPosition = 999
        scoreLabel.text = "0"
        bg.addChild(scoreLabel)
        
        liveIndicator = SKSpriteNode(imageNamed: "5lives")
        liveIndicator.position = gameSystem.liveIndicatorPosition
        liveIndicator.zPosition = 999
        liveIndicator.anchorPoint = CGPoint(x: 1, y: 1)
        bg.addChild(liveIndicator)
        
        pauseButton = ButtonNode(imageNamed: "pauseButton")
        let viewCoords = CGPoint(x: 10, y: 10)
        pauseButton.position = self.bg.convert(view.convert(viewCoords, to: self), from: self)
        pauseButton.size = CGSize(width: 100, height: 100)
        pauseButton.anchorPoint = CGPoint(x: 0, y: 1)
        pauseButton.zPosition = 999
        self.bg.addChild(pauseButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let collector = self.bg.nodes(at: touch.location(in: bg)).first as? CollectorNode {
                if collector.colorCode >= gameSystem.colors.count - 1 {
                    collector.colorCode = 0
                } else {
                    collector.colorCode += 1
                }
            } else if let node = self.nodes(at: touch.location(in: self)).first as? ButtonNode {
                let randomColor = UIColor(hue: CGFloat.random(), saturation: 1.0, brightness: 1.0, alpha: 1.0)
                node.run(SKAction.colorize(with: randomColor, colorBlendFactor: 0.7, duration: 0.1))
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bg.isPaused {
        } else {
            pauseButton.run(SKAction.colorize(withColorBlendFactor: 0, duration: 0.1))
            
            for touch in touches {
                if self.nodes(at: touch.location(in: self)).first == pauseButton {
                    addChild(pauseScreen)
                    pauseButton.removeAllActions()
                    pauseButton.run(SKAction.colorize(withColorBlendFactor: 0, duration: 0))
                    self.bg.isPaused = true
                    pauseScreen.run(SKAction.fadeIn(withDuration: 0.3))
                }
            }
        }
    }
}
