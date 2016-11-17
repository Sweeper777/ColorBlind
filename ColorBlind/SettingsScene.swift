import SpriteKit

class SettingsScene: SKScene {
    var bg: SKSpriteNode!
    override func didMove(to view: SKView) {
        bg = self.childNode(withName: "bg") as! SKSpriteNode
    }
}
