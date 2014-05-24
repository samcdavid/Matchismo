//
//  Card.h
//  Matchismo
//
//  Created by Sam McDavid on 5/18/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

/**
 *  An NSString property for storing the contents of a card.
 */
@property (strong, nonatomic) NSString *contents;

/**
 *  A boolean property for storing whether or not a card in the game is chosen.
 */
@property (nonatomic, getter = isChosen) BOOL chosen;

/**
 *  A boolean property for storing whether or not a card in the game 
 *  has been matched to another.
 */
@property (nonatomic, getter = isMatched) BOOL matched;

/**
 *  Determine if a card is matched to any card in the set and calculate the 
 *  appropriate score.
 *
 *  @param otherCards Set of cards to check for a match.
 *
 *  @return The caculated score.
 */
- (int)match:(NSArray *)otherCards;

@end
