//
//  MovesViewController.h
//  Matchismo
//
//  Created by Sam McDavid on 5/25/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovesViewController : UIViewController

/**
 *  Array that will contain the move history. It should only contain
 *  NSAttributedString objects.
 */
@property (strong, nonatomic) NSArray *turnDescriptions;

@end
