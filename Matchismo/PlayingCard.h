//
//  PlayingCard.h
//  Matchismo
//
//  Created by Sam McDavid on 5/18/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

/**
 *  Suit of the playing card.
 */
@property (strong, nonatomic) NSString *suit;

/**
 *  Rank of the playing card.
 */
@property (nonatomic) NSUInteger rank;

/**
 *  Class method to define an array of valid suits.
 *
 *  @return NSArray of valid suits.
 */
+ (NSArray *)validSuits;

/**
 *  The largest rank allowed for a playing card.
 *
 *  @return The largest rank allowed for a playing card.
 */
+ (NSUInteger)maxRank;

@end
