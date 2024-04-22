//
//  PlanePlaneCollision.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 13. 03. 24.
//

#import "PlanePlaneCollision.h"
#import "Rectangle.h"
#import "Vector2.h"
#import "Constants.h"
@implementation PlanePlaneCollision

+ (void) collisionBetween:(id)item1 and:(id)item2{
    
}

+ (Vector2 *)intersectionPointFrom:(Vector2 *)p1 to:(Vector2 *)p2 withLineFrom:(Vector2 *)p3 to:(Vector2 *)p4 {
    float denominator = ((p4.y - p3.y) * (p2.x - p1.x)) - ((p4.x - p3.x) * (p2.y - p1.y));

    // If the denominator is zero, the lines are parallel or coincident
    if (denominator == 0) {
        return nil;
    }

    float ua = (((p4.x - p3.x) * (p1.y - p3.y)) - ((p4.y - p3.y) * (p1.x - p3.x))) / denominator;
    float ub = (((p2.x - p1.x) * (p1.y - p3.y)) - ((p2.y - p1.y) * (p1.x - p3.x))) / denominator;

    // If ua and ub are between 0 and 1, the lines intersect
    if (ua >= 0 && ua <= 1 && ub >= 0 && ub <= 1) {
        float x = p1.x + ua * (p2.x - p1.x);
        float y = p1.y + ua * (p2.y - p1.y);
        return [Vector2 vectorWithX:x y:y];
    }

    return nil;
}
+ (float)distanceFrom:(Vector2 *)p1 to:(Vector2 *)p2 {
    float dx = p2.x - p1.x;
    float dy = p2.y - p1.y;
    return sqrtf(dx * dx + dy * dy);
}

+(Vector2 *) resolveCollisionBetween:(id<IBlock>) item1 position:(Vector2*)p1 position:(Vector2*)p2{
    Rectangle *rect=item1.block;
    float rotation=item1.rotation;

    // Create the four corners of the rectangle
    Vector2 *topLeft = [Vector2 vectorWithX:rect.x y:rect.y];
    Vector2 *topRight = [Vector2 vectorWithX:rect.x + rect.width y:rect.y];
    Vector2 *bottomLeft = [Vector2 vectorWithX:rect.x y:rect.y + rect.height];
    Vector2 *bottomRight = [Vector2 vectorWithX:rect.x + rect.width y:rect.y + rect.height];

    // Rotate the corners around the origin
    topRight = [self rotatePoint:topRight aroundOrigin:topLeft byRadians:rotation];
    bottomLeft = [self rotatePoint:bottomLeft aroundOrigin:topLeft byRadians:rotation];
    bottomRight = [self rotatePoint:bottomRight aroundOrigin:topLeft byRadians:rotation];

    // Check each side of the rectangle for intersection and keep track of the closest intersection point to p1
    Vector2 *closestIntersection = nil;
    float minDistance = FLT_MAX;
    NSArray *rectangleLines = @[@[topLeft, topRight], @[topRight, bottomRight], @[bottomRight, bottomLeft], @[bottomLeft, topLeft]];
    for (NSArray *line in rectangleLines) {
        Vector2 *intersection = [self intersectionPointFrom:p1 to:p2 withLineFrom:line[0] to:line[1]];
        if (intersection) {
            float distance = [self distanceFrom:p1 to:intersection];
            if (distance < minDistance) {
                minDistance = distance;
                closestIntersection = intersection;
            }
        }
    }
    if (closestIntersection) {
        Vector2 *direction = [Vector2 vectorWithX:p1.x - closestIntersection.x y:p1.y - closestIntersection.y];
        float length = sqrtf(direction.x * direction.x + direction.y * direction.y);
        Vector2 *unitDirection = [Vector2 vectorWithX:direction.x / length y:direction.y / length];
        Vector2 *moveVector = [Vector2 vectorWithX:unitDirection.x * [Constants radius]/2 y:unitDirection.y *[Constants radius]/2];
        closestIntersection = [Vector2 vectorWithX:closestIntersection.x + moveVector.x y:closestIntersection.y + moveVector.y];
    }
    return closestIntersection;
}

+ (BOOL) detectCollisionBetween:(id<IBlock>) item1 position:(Vector2*)p1 position:(Vector2*)p2{
    Rectangle *rect=item1.block;
    float rotation=item1.rotation;

    // Create the four corners of the rectangle
    Vector2 *topLeft = [Vector2 vectorWithX:rect.x y:rect.y];
    Vector2 *topRight = [Vector2 vectorWithX:rect.x + rect.width y:rect.y];
    Vector2 *bottomLeft = [Vector2 vectorWithX:rect.x y:rect.y + rect.height];
    Vector2 *bottomRight = [Vector2 vectorWithX:rect.x + rect.width y:rect.y + rect.height];

    // Rotate the corners around the origin
    topRight = [self rotatePoint:topRight aroundOrigin:topLeft byRadians:rotation];
    bottomLeft = [self rotatePoint:bottomLeft aroundOrigin:topLeft byRadians:rotation];
    bottomRight = [self rotatePoint:bottomRight aroundOrigin:topLeft byRadians:rotation];

    // Check if the line from p1 to p2 intersects with any of the rectangle's sides
    if ([self lineFrom:topLeft to:topRight intersectsLineFrom:p1 to:p2] ||
        [self lineFrom:topRight to:bottomRight intersectsLineFrom:p1 to:p2] ||
        [self lineFrom:bottomRight to:bottomLeft intersectsLineFrom:p1 to:p2] ||
        [self lineFrom:bottomLeft to:topLeft intersectsLineFrom:p1 to:p2]) {
        return YES;
    }

    return NO;
}

+ (BOOL)lineFrom:(Vector2 *)p1 to:(Vector2 *)p2 intersectsLineFrom:(Vector2 *)p3 to:(Vector2 *)p4 {
    float denominator = ((p4.y - p3.y) * (p2.x - p1.x)) - ((p4.x - p3.x) * (p2.y - p1.y));

    // If the denominator is zero, the lines are parallel or coincident
    if (denominator == 0) {
        return NO;
    }

    float ua = (((p4.x - p3.x) * (p1.y - p3.y)) - ((p4.y - p3.y) * (p1.x - p3.x))) / denominator;
    float ub = (((p2.x - p1.x) * (p1.y - p3.y)) - ((p2.y - p1.y) * (p1.x - p3.x))) / denominator;

    // If ua and ub are between 0 and 1, the lines intersect
    if (ua >= 0 && ua <= 1 && ub >= 0 && ub <= 1) {
        return YES;
    }

    return NO;
}

+ (Vector2 *)rotatePoint:(Vector2 *)point aroundOrigin:(Vector2 *)origin byRadians:(float)angle {
    float s = sinf(angle);
    float c = cosf(angle);

    // translate point back to origin:
    point.x -= origin.x;
    point.y -= origin.y;

    // rotate point
    float xnew = point.x * c - point.y * s;
    float ynew = point.x * s + point.y * c;

    // translate point back:
    point.x = xnew + origin.x;
    point.y = ynew + origin.y;
    return point;
}
@end
