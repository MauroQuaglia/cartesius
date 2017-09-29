# conics
Conics is a Ruby gem which allows you to solve some problems related to the conics in the cartesian plane.
The conics you are:
* Point (degenere conic)
* Line (degenere conic)
* Circumference
* Parabola
* Ellipse
* Hyperbola
* Homographic function

# Note
The new method is reserved for initialize the conic by equation. 
So, is better for you to use alternative methods (eg: create, by_points, by_definition, ...) to build the conic you want.
You can use number or string for your creation, for example you can use indifferently -1, '-1', 0, '1/2'.
i work with rationals so i get the maximum precision possible.  

#Point
You can create all points in the plane.

#Line
You can create all lines in the plane. 
You should use
```ruby 
create
``` 
to get a general inclined lines and
```ruby 
horizonal
``` 
or

```ruby 
vertical
``` 
method for horizontal or vertical lines.  

#Circumference
You can create all circumferences in the plane. 


## Getting Started
Edit your Gemfile and add:

        $ gem 'conics'
                
Now you can update your gemset with bundle.

## Coverage
Test coverage at 100%.

## License
Conics is released under the MIT License.

## Author
Mauro Quaglia

