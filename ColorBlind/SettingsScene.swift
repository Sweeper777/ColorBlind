import SpriteKit

class SettingsScene: SKScene {
    var bg: SKSpriteNode!
    override func didMove(to view: SKView) {
        bg = self.childNode(withName: "bg") as! SKSpriteNode
    }
}


//let bgmOn = !UserDefaults.standard.bool(forKey: "bgm")
//bgmButton = ButtonNode(imageNamed: "bgm_\(bgmOn)")
//bgmButton.zPosition = 1000
//viewCoords = CGPoint.zero
//let bgCoords = self.bg.convert(view.convert(viewCoords, to: self), from: self)
//bgmButton.position = CGPoint(x: bgCoords.x + 30, y: bgCoords.y - 30)
//bgmButton.anchorPoint = CGPoint(x: 0, y: 1)
//bgmButton.size = CGSize(width: 100, height: 100)
//bg.addChild(bgmButton)
//
//let soundEffectsOn = !UserDefaults.standard.bool(forKey: "soundEffects")
//soundEffectButton = ButtonNode(imageNamed: "soundEffects_\(soundEffectsOn)")
//soundEffectButton.zPosition = 1000
//viewCoords = CGPoint.zero
//soundEffectButton.position = CGPoint(x: bgmButton.position.x + bgmButton.frame.w + 30, y: bgmButton.position.y)
//soundEffectButton.anchorPoint = CGPoint(x: 0, y: 1)
//soundEffectButton.size = CGSize(width: 100, height: 100)
//bg.addChild(soundEffectButton)

//if node == bgmButton {
//    let bgm = UserDefaults.standard.bool(forKey: "bgm")
//    UserDefaults.standard.set(!bgm, forKey: "bgm")
//    bgmButton.texture = SKTexture(imageNamed: "bgm_\(bgm)")
//    if let vc = (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController as? GameViewController {
//        vc.audioPlayer.volume = bgm ? 1.0 : 0.0
//    }
//} else if node == soundEffectButton {
//    let soundEffects = UserDefaults.standard.bool(forKey: "soundEffects")
//    UserDefaults.standard.set(!soundEffects, forKey: "soundEffects")
//    soundEffectButton.texture = SKTexture(imageNamed: "soundEffects_\(soundEffects)")
//}
