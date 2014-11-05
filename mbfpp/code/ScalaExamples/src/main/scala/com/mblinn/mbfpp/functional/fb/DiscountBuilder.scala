package com.mblinn.mbfpp.functional.fb

object DiscountBuilder {

  def discount(percent: Double) = {
    if(percent < 0.0 || percent > 100.0) 
      throw new IllegalArgumentException("Discounts must be between 0.0 and 100.0.")
    (originalPrice: Double) => 
      originalPrice - (originalPrice * percent * 0.01)
  }
  
}