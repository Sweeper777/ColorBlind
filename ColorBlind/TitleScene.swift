import SpriteKit
import EZSwiftExtensions
import SwiftRandom

class TitleScene: SKScene {
    var bg: SKSpriteNode!
    var startButton: ButtonNode!
    
    override func didMove(to view: SKView) {
        bg = self.childNode(withName: "bg") as! SKSpriteNode
        
        let titleNode = SKSpriteNode(imageNamed: "title")
        titleNode.zPosition = 1000
        var viewCoords = CGPoint(x: view.w / 2, y: view.h / 14)
        titleNode.position = self.bg.convert(view.convert(viewCoords, to: self), from: self)
        titleNode.anchorPoint = CGPoint(x: 0.5, y: 1)
        let size = titleNode.size
        titleNode.size = CGSize(width: size.width * 1.4, height: size.height * 1.4)
        self.bg.addChild(titleNode)
        
        startButton = ButtonNode(imageNamed: "startbutton")
        startButton.zPosition = 1000
        viewCoords = CGPoint(x: view.w / 2, y: view.h * 0.7)
        startButton.position = self.bg.convert(view.convert(viewCoords, to: self), from: self)
        startButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        bg.addChild(startButton)
        
        let highscoreLabel = SKLabelNode(fontNamed: "Copperplate")
        viewCoords = CGPoint(x: 20, y: view.h * 0.95)
        highscoreLabel.position = self.bg.convert(view.convert(viewCoords, to: self), from: self)
        highscoreLabel.horizontalAlignmentMode = .left
        highscoreLabel.fontSize = 50
        highscoreLabel.fontColor = UIColor.white
        highscoreLabel.zPosition = 2001
        highscoreLabel.text = "Highcore: \(UserDefaults.standard.integer(forKey: "highscore"))"
        bg.addChild(highscoreLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let node = self.nodes(at: touch.location(in: self)).first as? ButtonNode {
                let randomColor = UIColor(hue: CGFloat.random(), saturation: 1.0, brightness: 1.0, alpha: 1.0)
                node.run(SKAction.colorize(with: randomColor, colorBlendFactor: 0.7, duration: 0.1))
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for child in bg.children {
                child.run(SKAction.colorize(withColorBlendFactor: 0, duration: 0.1))
        }
        
        for touch in touches {
            if self.nodes(at: touch.location(in: self)).first == startButton {
                if let scene = GameScene(fileNamed: "GameScene") {
                    scene.scaleMode = .aspectFill
                    let transition = SKTransition.fade(withDuration: 0.5)
                    view?.presentScene(scene, transition: transition)
                    return
                }
            }
        }
    }
}
