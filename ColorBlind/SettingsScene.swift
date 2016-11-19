import SpriteKit

class SettingsScene: SKScene {
    var bg: SKSpriteNode!
    var backButton: ButtonNode!
    var bgmButton: ButtonNode!
    var soundEffectButton: ButtonNode!
    
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
        soundEffectButton.position = getBgPosition(row: 3)
        soundEffectButton.anchorPoint = CGPoint(x: 0.5, y: 1)
        soundEffectButton.size = CGSize(width: 200, height: 200)
        bg.addChild(soundEffectButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let node = self.nodes(at: touch.location(in: self)).first as? ButtonNode {
                let randomColor = UIColor(hue: CGFloat.random(), saturation: 1.0, brightness: 1.0, alpha: 1.0)
                node.removeAllActions()
                node.run(SKAction.colorize(with: randomColor, colorBlendFactor: 0.7, duration: 0.1))
                if !UserDefaults.standard.bool(forKey: "soundEffects") {
                    node.run(SKAction.playSoundFileNamed("ting.wav", waitForCompletion: false))
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
        for child in bg.children {
            child.removeAllActions()
            child.run(SKAction.colorize(withColorBlendFactor: 0, duration: 0.1))
        }
    }
    
    func getBgPosition(row: Int) -> CGPoint {
        let viewCoords = CGPoint(x: view!.w / 2, y: view!.h * (CGFloat(row) / 10.0))
        return self.bg.convert(view!.convert(viewCoords, to: self), from: self)
    }
}
