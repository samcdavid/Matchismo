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
 *  Abstract method that needs to be overridden for each card matching game.
 *
 *  @return Deck the game will be played with.
 */
- (Deck *)createDeck;

/**
 *  Method to obtain the move history from the CardMatchingGame instance.
 *
 *  @return NSAttributedString turn descriptions.
 */
- (NSArray *)attributedCardGameTurnDescriptions;

@end
