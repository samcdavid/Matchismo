//
//  SetCard.h
//  Matchismo
//
//  Created by Sam McDavid on 5/25/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

/**
 *  Rank of the Set Card.
 */
@property (nonatomic) NSUInteger rank;

/**
 *  Symbol of the Set Card.
 */
@property (strong, nonatomic) NSString *symbol;

/**
 *  Shade string of the Set Card.
 */
@property (strong, nonatomic) NSString *shadeString;

/**
 *  Color string of the Set Card.
 */
@property (strong, nonatomic) NSString *colorString;

/**
 *  Attributed version of contents.
 */
@property (strong, nonatomic, readonly) NSAttributedString *attributedContents;

/**
 *  Dictionary instance for rank, symbol, shade, and color.
 */
@property (strong, nonatomic, readonly) NSDictionary *propertyDictionary;

/**
 *  Valid ranks of a Set Card are from 1 to n.
 *
 *  @return maximum valid rank
 */
+ (NSUInteger)maxRank;

/**
 *  Valid symbols of a set game card.
 *
 *  @return valid symbols.
 */
+ (NSArray *)validSymbols;

/**
 *  Valid shades of a set game card.
 *
 *  @return valid shades.
 */
+ (NSArray *)validShades;

/**
 *  Valid colors of a set game card.
 *
 *  @return valid colors.
 */
+ (NSArray *)validColors;

@end
