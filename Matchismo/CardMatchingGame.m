//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Sam McDavid on 5/20/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

/**
 *  Redeclare score so that it may be editable within the implementation of CardMatchingGame.
 */
@property (nonatomic, readwrite) NSInteger score;

/**
 *  Cards in use in the game.
 */
@property (strong, nonatomic) NSMutableArray *cards;

/**
 *  An array of all of the actions taken by the user and their outcomes.
 *  Only NSString objects should exist in this NSMutableArray.
 */
@property (strong, nonatomic) NSMutableArray *turnDescriptions;

@end

@implementation CardMatchingGame

// Constants
static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;

// Property Methods
- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)turnDescriptions {
    if (!_turnDescriptions) _turnDescriptions = [[NSMutableArray alloc] init];
    return _turnDescriptions;
}

// Public Methods
- (instancetype)init {
    return nil;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
    
    [self.turnDescriptions addObject:card.contents];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen &&
                    !otherCard.isMatched &&
                    [chosenCards count] != (self.numberOfCardsToMatch -1)) {
                    [chosenCards addObject:otherCard];
                }
                if ([chosenCards count] == (self.numberOfCardsToMatch - 1)) {
                    NSInteger matchScore = [card match:chosenCards] * MATCH_BONUS * self.numberOfCardsToMatch;
                    NSString *descriptionOfTurn = [NSString stringWithFormat:@""];
                    if (matchScore) {
                        descriptionOfTurn = [descriptionOfTurn stringByAppendingFormat:@"Matched %@ ", card.contents];
                        self.score += matchScore;
                        for (Card *matchedCard in chosenCards) {
                            matchedCard.matched = YES;
                            descriptionOfTurn = [descriptionOfTurn stringByAppendingFormat:@"%@ ", matchedCard.contents];
                        }
                        card.matched = YES;
                        descriptionOfTurn = [descriptionOfTurn stringByAppendingFormat:@"For %ld points.", matchScore];
                    } else {
                        NSInteger penalty = MISMATCH_PENALTY * (self.numberOfCardsToMatch - 1);
                        self.score -= penalty;
                        descriptionOfTurn = [descriptionOfTurn stringByAppendingFormat:@"%@ ", card.contents];
                        for (Card *unmatchedCard in chosenCards) {
                            descriptionOfTurn = [descriptionOfTurn stringByAppendingFormat:@"%@ ", unmatchedCard.contents];
                            unmatchedCard.chosen = NO;
                        }
                        descriptionOfTurn = [descriptionOfTurn stringByAppendingFormat:@"did not match %ld point penalty.", penalty];
                    }
                    [self.turnDescriptions addObject:descriptionOfTurn];
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index <[self.cards count]) ? self.cards[index] : nil;
}

- (NSString *)getLastTurnDescriptionString {
    return [self getTurnDescriptionStringAtIndex:([self.turnDescriptions count] - 1)];
}

- (NSString *)getTurnDescriptionStringAtIndex:(NSUInteger)index {
    return (index <= [self.turnDescriptions count]) ? self.turnDescriptions[index] : nil;
}

@end
