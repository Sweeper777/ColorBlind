import SpriteKit

class CollectorNode: SKSpriteNode {
    weak var gameSystem: GameSystem?
    var colorCode: Int = 0 {
        didSet {
            if let color = gameSystem?.colors[colorCode] {
                self.run(SKAction.colorize(with: color, colorBlendFactor: 0.7, duration: 0.1))
            }
        }
    }
    
    init(gameSystem: GameSystem) {
        super.init(texture: SKTexture(imageNamed: "collector"), color: UIColor.clear, size: CGSize(width: gameSystem.laneWidth * 0.8, height: gameSystem.laneWidth * 0.8))
        self.gameSystem = gameSystem
        self.anchorPoint = CGPoint(x: 0.5, y: -0.3)
        self.run(SKAction.colorize(with: gameSystem.colors[0], colorBlendFactor: 0.7, duration: 0))
        self.zPosition = 1001
        gameSystem.scene?.bg.addChild(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
