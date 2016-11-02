import SpriteKit

class GameScene: SKScene {
    var bg: SKSpriteNode!
    var gameSystem: GameSystem!
    
    override func didMove(to view: SKView) {
        view.ignoresSiblingOrder = true
        bg = self.childNode(withName: "bg") as! SKSpriteNode
        
        gameSystem = GameSystem(scene: self)
        let block = Block(gameSystem: gameSystem, colorCode: 0, lane: 0)
        self.bg.addChild(block.node)
    }
}
