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
 *  NSDictionary of attributes for attributed strings.
 */
@property (strong, nonatomic, readonly) NSDictionary *attributesDictionary;

/**
 *  Abstract method that needs to be overridden for each card matching game.
 *
 *  @return Deck the game will be played with.
 */
- (Deck *)createDeck;

/**
 *  Abstract method for determining the attributed string of a given card. This
 *  is specfic to each CardGameViewController.
 *
 *  @param card Card instance to get the attributed string for.
 *
 *  @return Attributed string for Card instance.
 */
- (NSMutableAttributedString *)attributedContentsOfCard:(Card *)card;

@end
