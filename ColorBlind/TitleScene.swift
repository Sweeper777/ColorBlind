import SpriteKit
import EZSwiftExtensions
import SwiftRandom

class TitleScene: SKScene {
    var bg: SKSpriteNode!
    var startButton: ButtonNode!
    var bgmButton: ButtonNode!
    var soundEffectButton: ButtonNode!
    
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
        
        let bgmOn = !UserDefaults.standard.bool(forKey: "bgm")
        bgmButton = ButtonNode(imageNamed: "bgm_\(bgmOn)")
        bgmButton.zPosition = 1000
        viewCoords = CGPoint.zero
        let bgCoords = self.bg.convert(view.convert(viewCoords, to: self), from: self)
        bgmButton.position = CGPoint(x: bgCoords.x + 30, y: bgCoords.y - 30)
        bgmButton.anchorPoint = CGPoint(x: 0, y: 1)
        bgmButton.size = CGSize(width: 100, height: 100)
        bg.addChild(bgmButton)
        
        let soundEffectsOn = !UserDefaults.standard.bool(forKey: "soundEffects")
        soundEffectButton = ButtonNode(imageNamed: "soundEffects_\(soundEffectsOn)")
        soundEffectButton.zPosition = 1000
        viewCoords = CGPoint.zero
        soundEffectButton.position = CGPoint(x: bgmButton.position.x + bgmButton.frame.w + 30, y: bgmButton.position.y)
        soundEffectButton.anchorPoint = CGPoint(x: 0, y: 1)
        soundEffectButton.size = CGSize(width: 100, height: 100)
        bg.addChild(soundEffectButton)
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
            let node = self.nodes(at: touch.location(in: self)).first
            if node == startButton {
                if let scene = GameScene(fileNamed: "GameScene") {
                    scene.scaleMode = .aspectFill
                    let transition = SKTransition.fade(withDuration: 0.5)
                    view?.presentScene(scene, transition: transition)
                    return
                }
            } else if node == bgmButton {
                let bgm = UserDefaults.standard.bool(forKey: "bgm")
                UserDefaults.standard.set(!bgm, forKey: "bgm")
                bgmButton.texture = SKTexture(imageNamed: "bgm_\(bgm)")
            } else if node == soundEffectButton {
                let soundEffects = UserDefaults.standard.bool(forKey: "soundEffects")
                UserDefaults.standard.set(!soundEffects, forKey: "soundEffects")
                soundEffectButton.texture = SKTexture(imageNamed: "soundEffects_\(soundEffects)")
            }
        }
    }
}
