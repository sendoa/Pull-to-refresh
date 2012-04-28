//
//  QBKDatosStore.h
//  Pull To Refresh
//
//  Created by Sendoa Portuondo on 27/04/12.
//  Copyright (c) 2012 Qbikode Solutions, S.L. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QBKDatosStore : NSObject

+ (QBKDatosStore *)sharedInstance;
- (NSArray *)todosLosDatos;
@end
