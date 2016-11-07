import SpriteKit

class GameOverScene: SKScene {
    var score: Int = 0
    var bg: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        bg = self.childNode(withName: "bg") as! SKSpriteNode
        let gameOverLabel = SKLabelNode(fontNamed: "Copperplate")
        var viewCoords = CGPoint(x: self.view!.w / 2, y: self.view!.h / 5)
        gameOverLabel.position = bg.convert(self.view!.convert(viewCoords, to: self), from: self)
        gameOverLabel.fontSize = 160
        gameOverLabel.fontColor = UIColor.white
        gameOverLabel.zPosition = 2001
        gameOverLabel.text = "GAME\nOVER"
        bg.addChild(gameOverLabel)
    }
}
