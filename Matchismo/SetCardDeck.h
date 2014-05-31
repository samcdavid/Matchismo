//
//  SetCardDeck.h
//  Matchismo
//
//  Created by Sam McDavid on 5/31/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import "Deck.h"
#import "SetCard.h"

@interface SetCardDeck : Deck

/**
 *  Designated initializer for SetCard Deck. Controls the property variations for 
 *  SetCard.
 *
 *  @param number  The maximum number of symbols to be displayed on a SetCard. Will
 *  also be used to determine the number of symbols, colors, and shades that can
 *  be used.
 *  @param symbols Array of symbol descriptions for the SetCards. Must contain
 *  NSString objects.
 *  @param shades  Array of shade descriptions for the SetCards. Must contain
 *  NSString objects.
 *  @param colors  Array of color descriptions for the SetCards. Must contain
 *  NSString objects.
 *
 *  @return A full deck of SetCards.
 */
- (instancetype)initWithSymbolNumber: (NSUInteger)number
                             symbols: (NSArray *)symbols
                              shades: (NSArray *)shades
                              colors: (NSArray *)colors;

/**
 *  Array of valid symbols that is set by the designated initializer.
 */
@property (strong, nonatomic, readonly) NSArray *validSymbols;

/**
 *  Array of valid shades that is set by the designated initializer.
 */
@property (strong, nonatomic, readonly) NSArray *validShades;

/**
 *  Array of valid colors that is set by the designated initializer.
 */
@property (strong, nonatomic, readonly) NSArray *validColors;

@end
