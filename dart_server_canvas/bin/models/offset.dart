import 'dart:convert';

class Offset {
  final double dx;
  final double dy;
  
  Offset({
    this.dx,
    this.dy,
  });

  Map<String, dynamic> toMap() {
    return {
      'dx': dx,
      'dy': dy,
    };
  }

  factory Offset.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Offset(
      dx: map['dx'],
      dy: map['dy'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Offset.fromJson(String source) => Offset.fromMap(json.decode(source));

  @override
  String toString() => 'Offset(dx: $dx, dy: $dy)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Offset &&
      o.dx == dx &&
      o.dy == dy;
  }

  @override
  int get hashCode => dx.hashCode ^ dy.hashCode;
}
