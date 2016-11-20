import SpriteKit

class SettingsScene: SKScene {
    var bg: SKSpriteNode!
    var backButton: ButtonNode!
    var bgmButton: ButtonNode!
    var soundEffectButton: ButtonNode!
    
    var easyButton: SKSpriteNode!
    var normalButton: SKSpriteNode!
    var hardButton: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        bg = self.childNode(withName: "bg") as! SKSpriteNode
        
        backButton = ButtonNode(imageNamed: "backButton")
        backButton.zPosition = 1000
        let bgCoords = self.bg.convert(view.convert(CGPoint.zero, to: self), from: self)
        backButton.position = CGPoint(x: bgCoords.x + 30, y: bgCoords.y - 30)
        backButton.anchorPoint = CGPoint(x: 0, y: 1)
        backButton.size = CGSize(width: 100, height: 100)
        bg.addChild(backButton)
        
        let bgmOn = !UserDefaults.standard.bool(forKey: "bgm")
        bgmButton = ButtonNode(imageNamed: "bgm_\(bgmOn)")
        bgmButton.zPosition = 1000
        bgmButton.position = getBgPosition(row: 2)
        bgmButton.anchorPoint = CGPoint(x: 0.5, y: 1)
        bgmButton.size = CGSize(width: 200, height: 200)
        bg.addChild(bgmButton)
        
        let soundEffectsOn = !UserDefaults.standard.bool(forKey: "soundEffects")
        soundEffectButton = ButtonNode(imageNamed: "soundEffects_\(soundEffectsOn)")
        soundEffectButton.zPosition = 1000
        soundEffectButton.position = getBgPosition(row: 5)
        soundEffectButton.anchorPoint = CGPoint(x: 0.5, y: 1)
        soundEffectButton.size = CGSize(width: 200, height: 200)
        bg.addChild(soundEffectButton)
        
        let difficultyLabel = SKLabelNode(text: "DIFFICULTY")
        difficultyLabel.zPosition = 1000
        difficultyLabel.fontName = "Copperplate"
        difficultyLabel.fontSize = 60
        difficultyLabel.position = getBgPosition(row: 10)
        bg.addChild(difficultyLabel)
        
        easyButton = SKSpriteNode(imageNamed: "easyButton")
        easyButton.zPosition = 1000
        easyButton.position = getBgPosition(row: 11)
        easyButton.anchorPoint = CGPoint(x: 0.5, y: 1)
        bg.addChild(easyButton)
        
        normalButton = SKSpriteNode(imageNamed: "normalButton")
        normalButton.zPosition = 1000
        normalButton.position = getBgPosition(row: 12)
        normalButton.anchorPoint = CGPoint(x: 0.5, y: 1)
        bg.addChild(normalButton)
        
        hardButton = SKSpriteNode(imageNamed: "hardButton")
        hardButton.zPosition = 1000
        hardButton.position = getBgPosition(row: 13)
        hardButton.anchorPoint = CGPoint(x: 0.5, y: 1)
        bg.addChild(hardButton)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let node = self.nodes(at: touch.location(in: self)).first
            if let btnNode = node as? ButtonNode {
                let randomColor = UIColor(hue: CGFloat.random(), saturation: 1.0, brightness: 1.0, alpha: 1.0)
                btnNode.removeAllActions()
                btnNode.run(SKAction.colorize(with: randomColor, colorBlendFactor: 0.7, duration: 0.1))
                if !UserDefaults.standard.bool(forKey: "soundEffects") {
                    btnNode.run(SKAction.playSoundFileNamed("ting.wav", waitForCompletion: false))
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let node = self.nodes(at: touch.location(in: self)).first
            if node == backButton {
                if let scene = TitleScene(fileNamed: "TitleScene") {
                    scene.scaleMode = .aspectFill
                    let transition = SKTransition.fade(withDuration: 0.5)
                    view?.presentScene(scene, transition: transition)
                    return
                }
            } else if node == bgmButton {
                let bgm = UserDefaults.standard.bool(forKey: "bgm")
                UserDefaults.standard.set(!bgm, forKey: "bgm")
                bgmButton.texture = SKTexture(imageNamed: "bgm_\(bgm)")
                if let vc = (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController as? GameViewController {
                    vc.audioPlayer.volume = bgm ? 1.0 : 0.0
                }
            } else if node == soundEffectButton {
                let soundEffects = UserDefaults.standard.bool(forKey: "soundEffects")
                UserDefaults.standard.set(!soundEffects, forKey: "soundEffects")
                soundEffectButton.texture = SKTexture(imageNamed: "soundEffects_\(soundEffects)")
            }
        }
        for child in bg.children where child is ButtonNode {
            child.removeAllActions()
            child.run(SKAction.colorize(withColorBlendFactor: 0, duration: 0.1))
        }
    }
    
    func getBgPosition(row: Int) -> CGPoint {
        let viewCoords = CGPoint(x: view!.w / 2, y: view!.h * (CGFloat(row) / 20.0))
        return self.bg.convert(view!.convert(viewCoords, to: self), from: self)
    }
}
