# conics
Conics is a Ruby gem which allows you to solve some problems related to the conics in the cartesian plane.
The conics you are:
* Point
* Line
* Circumference
* Parabola
* Ellipse
* Hyperbola
* Homographic function

# Note
The new method allow you to create the conic by coefficients. Not all combinations of coefficients are allowed, and an exception could be raised.
So, if you want, you can use alternative methods (eg: create, by_points, by_definition, ...) to build the conic you want.
You can use number or string for your creation, for example you can use indifferently -1, '-1', 0, '1/2'.
I work with rationals so i get the maximum precision possible during calculations.  

#Point
You can create all points in the plane.
Remember that point is a degenerate conic and its equation is like this:
```ruby 
x^2 + y^2 + dx + ey + f = 0
```

#Line
You can create all lines in the plane. 
Remember that line is a degenerate conic and its equation is like this:
```ruby 
dx + ey + f = 0
```

#Circumference
You can create all circumferences in the plane.
Remember that circumference is a conic and its equation is like this:
```ruby 
x^2 + y^2 + dx + ey + f = 0
```

#Parabola
You can create all parabola in the plane with axis of symmetry parallel to the y-axis.
Remember that parabola is a conic and its equation is like this:
```ruby 
ax^2 + dx - y + f = 0
```

## Getting Started
Edit your Gemfile and add:
```ruby 
gem 'conics'
```
Now you can update your gemset with bundle.

## Coverage
Test coverage at 100%.

## License
Conics is released under the MIT License.

## Author
Mauro Quaglia

