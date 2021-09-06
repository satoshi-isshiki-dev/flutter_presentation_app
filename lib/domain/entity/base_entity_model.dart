// ? Зачем я это сделал:
// ! Чтобы потом при работе с дженериками в методах post и get, 
// ! можно было особо не извращаясь обращаться к методу toJson через тип T 

abstract class BaseModel<T> {
  int? id;
  Map<String, dynamic> toJson();
  // T fromJson(Map<String, dynamic> json);
}