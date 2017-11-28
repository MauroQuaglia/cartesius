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

=====

# Point
The point is a fundamental entity and there isn't a definition. 
The general equation is like:
```
    x^2 + y^2 + dx + ey + f = 0; 
    with d, e, f in R.
```
You can create all points in the plan.

# Line
The line is a fundamental entity and there isn't a definition. 
The general equation is like:
```
    dx + ey + f = 0;
    with d, e, f in R;
```
You can create all lines in the plan.

# Segment
The segment is a line bounded by two points, called extremes. 
The general equation is like:
```
    dx + ey + f = 0;
    with d, e, f in R;
    with restriction for x and y;
```
You can create all segments in the plan.

# Circumference
A circumference is the locus of points in the plan for which the distances from one fixed points (the center) is constant.

In symbols:
```
    |PC| = d;
    where P is the point, C the center and d > 0;
```

Circumference is a conic and the general equation is:
```
    x^2 + y^2 + dx + ey + f = 0;
    with d, e, f in R;
```

You can create all circumferences in the plan.

# Parabola
Definition:
A parabola is the locus of points in the plan for which the distance from a line (the directrix) and a point (the focus) is the same.

In symbols:
```
    |Pd| = |PF|
    where P is the point, d the directrix and F the focus;
    where F not in directrix;
```

Parabola is a conic and the general equation is:
```
    ax^2 + dx - y + f = 0;
    with a, d, f in R;
```
You can create all the parabola with directrix parallel to the x-axis in the plan.


# Ellipse
A ellipse is the locus of points in the plan for which the sum of the distances from two fixed points (the foci) is constant.

In symbols:
```
    |PF1 + PF2| = d;
    where P is a point, and F1, F2 the foci;
    where F1 != F2 and d > |F1F2|
```

Ellipse is a conic and the general equation is:
```
    ax^2 + by^2 + dx + ey + f = 0
    with a, b, d, e, f in R;
```

You can create all the ellipsis with axes parallel to the coordinate axes in the plan.


# Hyperbola
A hyperbola is the locus of points in the plan for which the difference of the distances from two fixed points (the foci) is constant.

In symbols:
```
    |PF1 - PF2| = d, 
    where P is a point, and F1, F2 the foci;
    where F1 != F2 and d < |F1F2|
```

Hyperbola is a conic and the general equation is:
```
    ax^2 + by^2 + dx + ey + f = 0
    with a, b, d, e, f in R;
```

You can create all the hyperbola with axes parallel to the coordinate axes in the plan. 


## Getting Started
Edit your Gemfile and add:
```ruby
    gem 'cartesius'
```
Now you can update your gemset with bundle.

## Code Quality
Test coverage at 100%.

## License
Cartesius is released under the MIT License.

## Author
Mauro Quaglia


    
