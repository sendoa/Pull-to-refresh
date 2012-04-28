//
//  QBKRootViewController.h
//  Pull To Refresh
//
//  Created by Sendoa Portuondo on 27/04/12.
//  Copyright (c) 2012 Qbikode Solutions, S.L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@class QBKDatosStore;

@interface QBKRootViewController : UITableViewController <EGORefreshTableHeaderDelegate>
{
    NSArray *_datos;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}

@end
