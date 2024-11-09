// Implementation of 2D rectangle.
//
#import math

// x and y are top-left position of the rectangle
def Rect2 struct (x float, y float, width float, height float)
impl Rect2.get_area (self Rect2) (area float) {
    (self.width, self.height) > mul > return
}
impl Rect2.get_size (self Rect2) (size Vector2) {
    (self.width, self.height) > math.Vector2.new > return
}
