//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Sam McDavid on 5/25/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "MovesViewController.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SetCardGameMovesSegue"] &&
        [segue.destinationViewController isKindOfClass:[MovesViewController class]]) {
        MovesViewController *turnDescriptionController = (MovesViewController *)segue.destinationViewController;
        [turnDescriptionController setTurnDescriptions:[self attributedCardGameTurnDescriptions]];
    }
}


@end
