//
//  GameScene.swift
//  MobileCourseGame
//
//  Created by Andrew Godfroy on 2015-03-22.
//  Copyright (c) 2015 Andrew Godfroy. All rights reserved.
//

import SpriteKit
import Social;

class GameOverScene: SKScene {
    let backgroundImage = SKSpriteNode(imageNamed: "MainScreenBombOrDie");
    let gameOverButton = SKSpriteNode(imageNamed: "Gameover");
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        self.gameOverButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + (150 * 1));
        
        self.addChild(self.backgroundImage);
        self.addChild(self.gameOverButton);        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self);
            
            var scene = GameScene(size:self.size);
            let skView = self.view as SKView?;
            skView?.presentScene(scene);
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
