//
//  InGameScene.swift
//  animations1
//
//  Created by Andrew Godfroy on 2015-03-02.
//  Copyright (c) 2015 Andrew Godfroy. All rights reserved.
//

import SpriteKit
import Social;

class InGameScene: SKScene, SKPhysicsContactDelegate {
    var background = SKSpriteNode();
    var bird = SKSpriteNode();
    var ground = SKNode();
    var roof = SKNode();
    //var pipeScoreArea = SKNode();
    
    var scoreText = SKLabelNode();
    var score = 0;
    
    let playerCollisionGroup:UInt32 = 1;
    let gameOverCollisionGroup:UInt32 = 2;
    let gainScoreCollisionGroup:UInt32 = 3;
    
    override func didMoveToView(view: SKView) {
        var bgTexture = SKTexture(imageNamed: "bg.png");
        var moveBG = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 9);
        var replaceBG = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0);
        var moveBGForever = SKAction.repeatActionForever(SKAction.sequence([moveBG, replaceBG]));
        for (var i :CGFloat = 0; i < 3; i++) {
            background = SKSpriteNode(texture: bgTexture);
            background.position = CGPoint(x:bgTexture.size().width / 2 + bgTexture.size().width * i,
                y:CGRectGetMidY(self.frame));
            background.size.height = self.frame.height;
            background.runAction(moveBGForever);
            self.addChild(background);
        }
        
        // Ground
        ground.position = CGPointMake(0,0);
        ground.physicsBody = SKPhysicsBody(rectangleOfSize:CGSizeMake(self.frame.size.width, self.frame.size.height * 0.05));
        ground.physicsBody?.dynamic = false;
        ground.physicsBody?.usesPreciseCollisionDetection = false;
        ground.physicsBody?.categoryBitMask = gameOverCollisionGroup;
        self.addChild(ground);
        
        // Roof
        roof.position = CGPoint(x: 0, y: CGRectGetMidY(self.frame) + 100);
        roof.physicsBody = SKPhysicsBody(rectangleOfSize:CGSizeMake(self.frame.size.width, self.frame.size.height * 0.05));
        roof.physicsBody?.dynamic = false;
        roof.physicsBody?.usesPreciseCollisionDetection = false;
        roof.physicsBody?.categoryBitMask = gameOverCollisionGroup;
        self.addChild(roof);
        
        // Pipes
        var initialX = self.frame.width * 1;
        var initialY = 0;
        // Pipe Textures
        var topPipeTexture = SKTexture(imageNamed: "pipe1.png");
        var bottomPipeTexture = SKTexture(imageNamed: "pipe2.png");
        // Pipe Actions
        var movePipe = SKAction.moveByX(-initialX, y: 0, duration: 5);
        var replacePipe = SKAction.moveByX(initialX, y: 0, duration: 0);
        var movePipeForever = SKAction.repeatActionForever(SKAction.sequence([movePipe, replacePipe]));
        
        // Create Pipes
        var pipeWidth = topPipeTexture.size().width;
        var topPipeHeight = topPipeTexture.size().height / 2.2;
        var bottomPipeHeight = bottomPipeTexture.size().height / 6;
    
        // Top Pipe
        var topPipe = SKSpriteNode(texture: topPipeTexture);
        topPipe.position = CGPoint(x:initialX, y:self.frame.height);
        topPipe.size.width = pipeWidth;
        topPipe.size.height = topPipeHeight;
        topPipe.physicsBody = SKPhysicsBody(rectangleOfSize:CGSizeMake(pipeWidth, topPipeHeight));
        topPipe.physicsBody?.dynamic = false;
        topPipe.physicsBody?.usesPreciseCollisionDetection = false;
        topPipe.physicsBody?.categoryBitMask = gameOverCollisionGroup;
        topPipe.runAction(movePipeForever);
        self.addChild(topPipe);
        
        // Bottom Pipe
        var bottomPipe = SKSpriteNode(texture: bottomPipeTexture);
        bottomPipe.position = CGPoint(x:initialX, y:0);
        bottomPipe.size.width = pipeWidth;
        bottomPipe.size.height = bottomPipeHeight;
        bottomPipe.physicsBody = SKPhysicsBody(rectangleOfSize:CGSizeMake(pipeWidth, bottomPipeHeight));
        bottomPipe.physicsBody?.dynamic = false;
        bottomPipe.physicsBody?.usesPreciseCollisionDetection = false;
        bottomPipe.physicsBody?.categoryBitMask = gameOverCollisionGroup;
        bottomPipe.runAction(movePipeForever);
        self.addChild(bottomPipe);
        
        // Score Area
        var pipeScoreArea = SKNode();
        pipeScoreArea.position = CGPointMake(initialX,0);
        pipeScoreArea.physicsBody = SKPhysicsBody(rectangleOfSize:CGSizeMake(pipeWidth * 0.02, self.frame.height));
        pipeScoreArea.physicsBody?.dynamic = false;
        pipeScoreArea.physicsBody?.usesPreciseCollisionDetection = false;
        pipeScoreArea.physicsBody?.categoryBitMask = gainScoreCollisionGroup;
        pipeScoreArea.runAction(movePipeForever);
        self.addChild(pipeScoreArea);
        
        // Bird
        // Textures
        var birdTexture1 = SKTexture(imageNamed: "flappy1.png");
        var birdTexture2 = SKTexture(imageNamed: "flappy2.png");
        // Animations
        var animation = SKAction.animateWithTextures([birdTexture1, birdTexture2], timePerFrame:0.1);
        var makeBirdFlap = SKAction.repeatActionForever(animation);
        // Make Birds
        bird = SKSpriteNode(texture: birdTexture1);
        bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame));
        // Add the physics property to the bird node
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height / 2);
        bird.physicsBody?.dynamic = true;
        bird.physicsBody?.allowsRotation = false;
        bird.physicsBody?.usesPreciseCollisionDetection = false;
        bird.physicsBody?.categoryBitMask = playerCollisionGroup;
        bird.physicsBody?.collisionBitMask = gameOverCollisionGroup;
        bird.physicsBody?.contactTestBitMask = gainScoreCollisionGroup;
        // Start Animating the bird
        bird.runAction(makeBirdFlap);
        // Add To Scene
        self.addChild(bird)
        
        // Do the text;
        scoreText.text = String("Score: \(self.score)");
        scoreText.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame));
        scoreText.fontColor = SKColor.redColor();
        scoreText.fontSize = 48;
        self.addChild(scoreText);
        
        // Set the Set the Physics World
        self.physicsWorld.gravity = CGVectorMake(0, -1.0)
        self.physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            bird.physicsBody?.applyForce(CGVector(dx:0.0, dy:1000.0));
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        print("Collision Detected\n");
        
        //let firstNode = contact.bodyA.node as SKSpriteNode
        //let secondNode = contact.bodyB.node as SKSpriteNode
        
        if (contact.bodyA.categoryBitMask == gainScoreCollisionGroup ||
            contact.bodyB.categoryBitMask == gainScoreCollisionGroup) {
                print("Score!");
                
                self.score++;
                // Update the score text
                scoreText.text = String("Score: \(self.score)");
        }
        else if (contact.bodyA.categoryBitMask == gameOverCollisionGroup ||
            contact.bodyB.categoryBitMask == gameOverCollisionGroup) {
                var scene = GameOverScene(size:self.size);
                let skView = self.view as SKView?;
                skView?.presentScene(scene);
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        // Ensure the bird is always in the horizontal center
        bird.position.x = CGRectGetMidX(self.frame);
    }
}
