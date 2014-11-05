package com.mblinn.mbfpp.oo.visitor


trait PerimeterShapes {  
  trait Shape {
    def perimeter: Double
  }
  
  class Circle(radius: Double) extends Shape {
    def perimeter = 2 * Math.PI * radius
  }
  
  class Rectangle(width: Double, height: Double) extends Shape {
    def perimeter = 2 * width + 2 * height
  }
}

object FirstShapeExample extends PerimeterShapes {
  val aCircle = new Circle(4);
  val aRectangle = new Rectangle(2, 2);
}

trait AreaShapes extends PerimeterShapes {  
  trait Shape extends super.Shape {
    def area: Double
  }
  
  class Circle(radius: Double) extends super.Circle(radius) with Shape {
    def area = Math.PI * radius * radius
  }
  
  class Rectangle(width: Double, height: Double) 
  	extends super.Rectangle(width, height) with Shape {
    def area = width * height
  }
}

object SecondShapeExample extends AreaShapes {
    val someShapes = Vector(new Circle(4), new Rectangle(2, 2));
}

trait MorePerimeterShapes extends PerimeterShapes {
  class Square(side: Double) extends Shape {
    def perimeter = 4 * side;
  }
}

trait MoreAreaShapes extends AreaShapes with MorePerimeterShapes {
  class Square(side: Double) extends super.Square(side) with Shape {
    def area = side * side
  }
}

object ThirdShapeExample extends MoreAreaShapes {
    val someMoreShapes = Vector(new Circle(4), new Rectangle(2, 2), new Square(4));
}
