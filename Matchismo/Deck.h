//
//  Deck.h
//  Matchismo
//
//  Created by Sam McDavid on 5/18/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

/**
 *  An abstract property that must be implemented by the deck in order
 *  to determine how many cards the game should match against.
 */
@property (nonatomic, readonly) NSUInteger numberOfCardsToMatch;

/**
 *  Add a card to the top of a deck.
 *
 *  @param card  Card to be added to the top of the deck.
 *  @param atTop YES to add the card at the top.
 */
- (void)addCard:(Card *)card atTop:(BOOL)atTop;

/**
 *  Add a card to the deck. Calls addCard:card atTop:NO
 *
 *  @param card Card to be added to the deck.
 */
- (void)addCard:(Card *)card;

/**
 *  Draw and remove a random card from the deck.
 *
 *  @return The random Card that has been drawn from the deck.
 */
- (Card *)drawRandomCard;

@end
