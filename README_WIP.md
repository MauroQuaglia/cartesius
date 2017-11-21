# cartesius
Cartesius is a Ruby gem which allows you to solve some problems related to conics and geometry in the cartesian plane.
The models you are:
* Point
* Line
* Segment
* Circumference
* Parabola
* Ellipse
* Hyperbola

# Hyperbola
A hyperbola is the locus of points in the Euclidean plan for which the difference of the distances from two fixed points (the foci) is constant.

In symbols:
```ruby  
|PF1 - PF2| = d, where F1 != F2 and d < |F1F2|
```

Hyperbola is a conic and the general equation is:
```ruby 
ax^2 + by^2 + dx + ey + f = 0
```

Cartesisu allow you to create all the hyperbola with axes parallel to the coordinate axes in some way. 


# Ellipse
A ellipse is the locus of points in the Euclidean plan for which the sum of the distances from two fixed points (the foci) is constant.

In symbols:
```ruby   
|PF1 + PF2| = d, where F1 != F2 and d > |F1F2|
```

Ellipse is a conic and the general equation is:
```ruby 
ax^2 + by^2 + dx + ey + f = 0
```

Cartesisu allow you to create all the ellipsis with axes parallel to the coordinate axes in some way.

    
