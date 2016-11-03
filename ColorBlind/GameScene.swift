import SpriteKit

class GameScene: SKScene {
    var bg: SKSpriteNode!
    var gameSystem: GameSystem!
    
    override func didMove(to view: SKView) {
        view.ignoresSiblingOrder = true
        bg = self.childNode(withName: "bg") as! SKSpriteNode
        
        gameSystem = GameSystem(scene: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let collector = self.bg.nodes(at: touch.location(in: bg)).first as? CollectorNode {
                if collector.colorCode >= gameSystem.colors.count - 1 {
                    collector.colorCode = 0
                } else {
                    collector.colorCode += 1
                }
            }
        }
    }
}
