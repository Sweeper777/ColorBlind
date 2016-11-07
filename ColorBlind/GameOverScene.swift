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
        
        viewCoords = CGPoint(x: self.view!.w / 2, y: self.view!.h / 2)
        let bgCoords = bg.convert(self.view!.convert(viewCoords, to: self), from: self)
        
        let restartButton = ButtonNode(imageNamed: "restartButton")
        restartButton.position = CGPoint(x: bgCoords.x + 220, y: bgCoords.y)
        restartButton.size = CGSize(width: 200, height: 200)
        restartButton.zPosition = 2001
        restartButton.name = "restart"
        bg.addChild(restartButton)
        
        let mainMenuButton = ButtonNode(imageNamed: "menuButton")
        mainMenuButton.position = CGPoint(x: bgCoords.x - 220, y: bgCoords.y)
        mainMenuButton.size = CGSize(width: 200, height: 200)
        mainMenuButton.zPosition = 2001
        mainMenuButton.name = "menu"
        bg.addChild(mainMenuButton)
    }
}
