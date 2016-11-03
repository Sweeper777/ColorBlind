import SpriteKit

class Block {
    let node: SKSpriteNode
    let colorCode: Int
    let lane: Int
    let gameSystem: GameSystem
    
    init(gameSystem: GameSystem, colorCode: Int, lane: Int) {
        self.gameSystem = gameSystem
        self.colorCode = colorCode
        self.lane = lane
        node = SKSpriteNode(imageNamed: "block")
        node.position = gameSystem.blockPositions[lane]
        let fall = SKAction.moveTo(y: gameSystem.fallToYPosition, duration: gameSystem.fallSpeed)
        let onLanded = SKAction.run {
            self.gameSystem.onLanded(self)
        }
        node.anchorPoint = CGPoint(x: 0.5, y: 0)
        node.size = CGSize(width: gameSystem.laneWidth * 0.3, height: gameSystem.laneWidth * 0.3)
        node.zPosition = 1000
        node.run(SKAction.colorize(with: gameSystem.colors[colorCode], colorBlendFactor: 0.7, duration: 0))
        node.run(SKAction.sequence([fall, onLanded, SKAction.removeFromParent()]))
        gameSystem.scene?.bg.addChild(self.node)
    }
}
