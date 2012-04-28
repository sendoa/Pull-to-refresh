//
//  QBKDatosStore.m
//  Pull To Refresh
//
//  Created by Sendoa Portuondo on 27/04/12.
//  Copyright (c) 2012 Qbikode Solutions, S.L. All rights reserved.
//

#import "QBKDatosStore.h"

@implementation QBKDatosStore

+ (QBKDatosStore *)sharedInstance
{
	static QBKDatosStore *instancia;
	static dispatch_once_t once;
	
	dispatch_once(&once, ^{
		instancia = [[self alloc] init];
	});
	
	return instancia;
}

- (NSArray *)todosLosDatos
{
    // Generamos un número de objetos aleatorio
    srand(time(NULL));
    int numObjetos = rand() % 20 + 1;
    
    NSMutableArray *objetos = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < numObjetos; i++) {
        [objetos addObject:[NSString stringWithFormat:@"Fila %d de %d", i+1, numObjetos]];
    }
    
    return objetos;
}
@end
