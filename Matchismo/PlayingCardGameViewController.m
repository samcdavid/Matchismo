//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Sam McDavid on 5/24/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "MovesViewController.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PlayingCardMovesSegue"] &&
        [segue.destinationViewController isKindOfClass:[MovesViewController class]]) {
        MovesViewController *turnDescriptionController = (MovesViewController *)segue.destinationViewController;
        [turnDescriptionController setTurnDescriptions:[self attributedCardGameTurnDescriptions]];
    }
}


@end
