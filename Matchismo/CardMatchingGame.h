//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Sam McDavid on 5/20/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

/**
 *  Score of the CardMatchingGame is determined privately within the implementation of CardMatchingGame.
 */
@property (nonatomic, readonly) NSInteger score;

/**
 *  This is the designated init method for CardMatchingGame.
 *  The inherited init method will return nil.
 *
 *  @param count The number of cards to use with the card matching game.
 *  @param deck  The deck to be used with the game.
 *
 *  @return A CardMatchingGame
 */
- (instancetype)initWithCardCount: (NSUInteger)count
                        usingDeck: (Deck *)deck;

/**
 *  Choose a card in the game.
 *
 *  @param index The index of the card in the game.
 *  @param count The number of cards the game should match;
 */
- (void)chooseCardAtIndex: (NSUInteger)index
            andMatchCount: (NSUInteger)count;

/**
 *  Retrieve a card in the game with a certain index.
 *
 *  @param index Index of the card to be retrieved.
 *
 *  @return Card at the given index.
 */
- (Card *)cardAtIndex: (NSUInteger)index;

@end
