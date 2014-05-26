//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Sam McDavid on 5/18/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

/**
 *  Abstract readonly property whose getter must be overridden for each view controller.
 */
@property (nonatomic, readonly) NSUInteger numberOfCardsToMatch;

/**
 *  Abstract method that needs to be overridden for each card matching game.
 *
 *  @return Deck the game will be played with.
 */
- (Deck *)createDeck;

@end
