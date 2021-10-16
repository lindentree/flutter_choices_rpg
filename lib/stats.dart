import 'package:flutter/material.dart';

  class Stats extends InheritedWidget {
	
    const Stats({
	
      Key key,
	
      @required this.stats,
	
      @required Widget child,
	
    }) : assert(stats != null),
	
          assert(child != null),
	
          super(key: key, child: child);
	
  
	
    final Map stats;

    get health => stats['health'];

    get cash => stats['cash'];

	
    static Stats of(BuildContext context) {
      return context.dependOnInheritedWidgetOfExactType<Stats>();
    }
	
  
	
    @override
	
    bool updateShouldNotify(covariant Stats oldWidget) {
      return this.health != oldWidget.health;
    }
	
  }