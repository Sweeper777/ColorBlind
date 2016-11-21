import SpriteKit
import EZSwiftExtensions
import SwiftRandom

class GameSystem {
    weak var scene: GameScene?
    let blockPositions: [CGPoint]
    let collectorPositions: [CGPoint]
    let scoreLabelPosition: CGPoint
    let liveIndicatorPosition: CGPoint
    let colors: [UIColor]
    let fallToYPosition: CGFloat
    let numberOfLanes = 4
    let laneWidth: CGFloat
    var fallSpeed: TimeInterval = 4
    var collectors: [Collector] = []
    
    var newBlockClosure: (() -> Void)!
    
    var score: Int = 0 {
        didSet {
            scene?.scoreLabel.text = "\(score)"
            if score < 200 {
                fallSpeed = 4 - Double(score) / 80
            }
            
            if score == 100 {
                scene?.bg.removeAllActions()
                let waitAction = SKAction.wait(forDuration: 1.2)
                let finalAction = SKAction.repeatForever(SKAction.sequence([waitAction, SKAction.run(newBlockClosure)]))
                scene?.bg.run(finalAction)
            }
        }
    }
    
    var highscore: Int {
        get {
            return UserDefaults.standard.integer(forKey: "highscore")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "highscore")
        }
    }
    
    var lives: Int = 5 {
        didSet {
            scene?.liveIndicator.texture = SKTexture(imageNamed: "\(lives)lives")
        }
    }
    
    var difficulty: Int {
        return UserDefaults.standard.integer(forKey: "difficulty")
    }
    
    var highscoreKey: String {
        let difficulty = self.difficulty
        switch difficulty {
        case -1:
            return "Easy"
        case 0:
            return ""
        case 1:
            return "Hard"
        default:
            fatalError()
        }
    }
    
    func onLanded(_ block: Block) {
        let collector = collectors[block.lane]
        if collector.node.colorCode == block.colorCode {
            score += 1
            if !UserDefaults.standard.bool(forKey: "soundEffects") {
                collector.node.run(SKAction.playSoundFileNamed("ting.wav", waitForCompletion: false))
            }
        } else {
            if lives > 0 {
                lives -= 1
                let colorise = SKAction.colorize(with: UIColor.red, colorBlendFactor: 1, duration: 0.2)
                let decolorise = SKAction.colorize(withColorBlendFactor: 0, duration: 0.2)
                scene?.bg.run(SKAction.sequence([colorise, decolorise]))
                
                if lives == 0 {
                    self.scene?.bg.isPaused = true
                    if let scene = GameOverScene(fileNamed: "GameOverScene") {
                        scene.scaleMode = .aspectFill
                        
                        if score > highscore {
                            highscore = score
                            scene.newHighscore = true
                        }
                        scene.score = score
                        scene.highscore = highscore
                        let transition = SKTransition.fade(withDuration: 1)
                        self.scene?.gameSystem = nil
                        self.scene?.view?.presentScene(scene, transition: transition)
                    }
                }
            }
        }
    }
    
    init(scene: GameScene) {
        self.scene = scene
        let laneWidth = scene.view!.w / CGFloat(numberOfLanes)
        let point1 = CGPoint(x: laneWidth, y: 0)
        let point2 = CGPoint.zero
        let convertedPoint1 = scene.bg.convert(scene.view!.convert(point1, to: scene), from: scene)
        let convertedPoint2 = scene.bg.convert(scene.view!.convert(point2, to: scene), from: scene)
        self.laneWidth = convertedPoint1.x - convertedPoint2.x
        
        let fallToYPosition = scene.bg.convert(scene.view!.convert(CGPoint(x: 0, y: scene.view!.h - laneWidth), to: scene), from: scene).y
        self.fallToYPosition = fallToYPosition
        
        var blockPositions = [CGPoint]()
        for i in 0..<numberOfLanes {
            let x = laneWidth * CGFloat(i) + laneWidth / 2
            blockPositions.append(CGPoint(x: x, y: 0))
        }
        self.blockPositions = blockPositions.map { scene.bg.convert(scene.view!.convert($0, to: scene), from: scene) }
        let collectorPositions = blockPositions.map { CGPoint(x: $0.x, y: scene.view!.h) }
        self.collectorPositions = collectorPositions.map { scene.bg.convert(scene.view!.convert($0, to: scene), from: scene) }
        var colors = [UIColor]()
        let randomHue = CGFloat.random()
        let complement = fmod(randomHue + 0.5, 1.0)
        colors.append(UIColor(hue: randomHue, saturation: 1.0, brightness: 1.0, alpha: 1.0))
        colors.append(UIColor(hue: complement, saturation: 1.0, brightness: 1.0, alpha: 1.0))
        self.colors = colors
        
        let scoreLabelPosition = CGPoint(x: scene.view!.w / 2, y: scene.view!.h / 3)
        self.scoreLabelPosition = scene.bg.convert(scene.view!.convert(scoreLabelPosition, to: scene), from: scene)
        
        let liveIndicatorPosition = CGPoint(x: scene.view!.w - 20, y: 20)
        self.liveIndicatorPosition = scene.bg.convert(scene.view!.convert(liveIndicatorPosition, to: scene), from: scene)
        
        for i in 0..<numberOfLanes {
            collectors.append(Collector(gameSystem: self, lane: i))
        }
        
        newBlockClosure = {
            [unowned self] in
            var newBlocks = [(laneNumber: Int, colorCode: Int)]()
            let randomNumber = Int.random(0, 9)
            if randomNumber < 8 {
                newBlocks.append((Int.random(0, self.numberOfLanes - 1), Int.random(0, self.colors.count - 1)))
            }
            var laneNum = Int.random(0, self.numberOfLanes - 1)
            if randomNumber < 5 && !newBlocks.contains { $0.laneNumber == laneNum } {
                newBlocks.append((laneNum, Int.random(0, self.colors.count - 1)))
            }
            laneNum = Int.random(0, self.numberOfLanes - 1)
            if randomNumber < 2 && !newBlocks.contains { $0.laneNumber == laneNum } {
                newBlocks.append((laneNum, Int.random(0, self.colors.count - 1)))
            }
            
            let actionSequence = newBlocks.map({ tuple -> SKAction in
                let newBlockAction = SKAction.run {
                    [unowned self] in
                    _ = Block(gameSystem: self, colorCode: tuple.colorCode, lane: tuple.laneNumber)
                }
                let waitAction = SKAction.wait(forDuration: Double.random(0.05, 0.3))
                return SKAction.sequence([newBlockAction, waitAction])
            })
            scene.bg.run(SKAction.sequence(actionSequence))
        }
        
        let waitAction = SKAction.wait(forDuration: 1.3)
        let finalAction = SKAction.repeatForever(SKAction.sequence([waitAction, SKAction.run(newBlockClosure)]))
        scene.bg.run(finalAction)
    }
    
    deinit {
        for child in (scene!.bg.children) {
            child.removeAllActions()
            child.removeFromParent()
        }
    }
}
