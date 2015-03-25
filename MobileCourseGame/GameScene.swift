//
//  GameScene.swift
//  MobileCourseGame
//
//  Created by Andrew Godfroy on 2015-03-22.
//  Copyright (c) 2015 Andrew Godfroy. All rights reserved.
//

import SpriteKit
import Social;

class GameScene: SKScene {
    let backgroundImage = SKSpriteNode(imageNamed: "MainScreenBombOrDie");
    let title = SKSpriteNode(imageNamed: "title");
    let playButton = SKSpriteNode(imageNamed: "Play");
    
    let facebookButton = SKSpriteNode(imageNamed: "facebook");
    let twitterButton = SKSpriteNode(imageNamed: "twitter");
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        self.title.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        self.playButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + (150 * 1));
        
        self.facebookButton.position = CGPointMake(CGRectGetMidX(self.frame) - (100), CGRectGetMidY(self.frame) + (150 * 2));
        self.twitterButton.position = CGPointMake(CGRectGetMidX(self.frame) + 100, CGRectGetMidY(self.frame) + (150 * 2));
        
        self.addChild(self.backgroundImage);
        self.addChild(self.title);
        self.addChild(self.playButton);

        self.addChild(self.facebookButton);
        self.addChild(self.twitterButton);
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self);
            
            if (self.nodeAtPoint(location) == self.playButton) {
                print("Play Button Pressed\n");
                var scene = InGameScene(size:self.size);
                let skView = self.view as SKView?;
                skView?.presentScene(scene);
            }
            
            else if (self.nodeAtPoint(location) == self.facebookButton) {
                print("Facebook Button Pressed\n");
                let composeController = SLComposeViewController(forServiceType: SLServiceTypeFacebook);
                composeController.setInitialText("Hello Facebook");
                self.view?.window?.rootViewController?.presentViewController(composeController, animated:true, completion:nil);
            }
            
            else if (self.nodeAtPoint(location) == self.twitterButton) {
                print("Twitter Button Pressed\n");
                let composeController = SLComposeViewController(forServiceType: SLServiceTypeTwitter);
                composeController.setInitialText("Hello Twitter");
                self.view?.window?.rootViewController?.presentViewController(composeController, animated:true, completion:nil);
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
