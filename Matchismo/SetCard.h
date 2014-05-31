//
//  SetCard.h
//  Matchismo
//
//  Created by Sam McDavid on 5/31/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

/**
 *  The number of symbols to be displayed on the Set Card.
 */
@property (nonatomic) NSUInteger number;

/**
 *  The symbol to be displayed on the Set Card.
 */
@property (strong, nonatomic) NSString *symbol;

/**
 *  The shading of the Set Card.
 */
@property (strong, nonatomic) NSString *shading;

/**
 *  The color of the Set Card.
 */
@property (strong, nonatomic) NSString *color;

@end
