import SpriteKit

class GameOverScene: SKScene {
    var score = 0
    var highscore = 0
    var newHighscore = false
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
        
        let scoreLabel = SKLabelNode(fontNamed: "Copperplate")
        scoreLabel.position = bg.convert(self.view!.convert(CGPoint(x: viewCoords.x, y: viewCoords.y + view.h / 9), to: self), from: self)
        
        scoreLabel.fontSize = 50
        scoreLabel.fontColor = UIColor.white
        scoreLabel.zPosition = 2001
        scoreLabel.text = "Score: \(score)"
        bg.addChild(scoreLabel)
        
        let highscoreLabel = SKLabelNode(fontNamed: "Copperplate")
        highscoreLabel.position = bg.convert(self.view!.convert(CGPoint(x: viewCoords.x, y: viewCoords.y + view.h / 6), to: self), from: self)
        highscoreLabel.fontSize = 50
        highscoreLabel.fontColor = UIColor.white
        highscoreLabel.zPosition = 2001
        highscoreLabel.text = "Highcore: \(highscore)"
        bg.addChild(highscoreLabel)
        
        if newHighscore {
            let newHighscoreLabel = SKLabelNode(fontNamed: "Copperplate")
            newHighscoreLabel.position = bg.convert(self.view!.convert(CGPoint(x: viewCoords.x, y: viewCoords.y + view.h / 3), to: self), from: self)
            newHighscoreLabel.fontSize = 50
            newHighscoreLabel.fontColor = UIColor.white
            newHighscoreLabel.zPosition = 2001
            newHighscoreLabel.text = "NEW HIGHSCORE!"
            bg.addChild(newHighscoreLabel)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let node = self.nodes(at: touch.location(in: self)).first as? ButtonNode {
                let randomColor = UIColor(hue: CGFloat.random(), saturation: 1.0, brightness: 1.0, alpha: 1.0)
                node.run(SKAction.colorize(with: randomColor, colorBlendFactor: 0.7, duration: 0.1))
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for child in bg.children {
            child.run(SKAction.colorize(withColorBlendFactor: 0, duration: 0.1))
        }
        
        for touch in touches {
            if let button = self.nodes(at: touch.location(in: self)).first as? ButtonNode {
                switch button.name! {
                case "restart":
                    if let scene = GameScene(fileNamed: "GameScene") {
                        scene.scaleMode = .aspectFill
                        let transition = SKTransition.fade(withDuration: 0.5)
                        view?.presentScene(scene, transition: transition)
                        return
                    }
                case "menu":
                    if let scene = TitleScene(fileNamed: "TitleScene") {
                        scene.scaleMode = .aspectFill
                        let transition = SKTransition.fade(withDuration: 0.5)
                        view?.presentScene(scene, transition: transition)
                    }
                default:
                    break
                }
                button.removeAllActions()
                button.run(SKAction.colorize(withColorBlendFactor: 0, duration: 0))
            }
        }
    }
}
