package com.behindcurtain3.astar
{
	import mx.core.FlexGlobals;
	import flash.geom.Point;
	import flash.display.*;
	import mx.collections.*;
	
	/**
	 * ...
	 * @author Justin Brown
	 * Used for pathfinding with A*
	 */
	public class Node
	{
		public var f:Number;
		public var g:Number;
		public var h:Number;
		public var moveable:Boolean;
		public var parent:Node;
		
		// Position in the array
		public var x:int;
		public var y:int;
		
		// World position
		public var position:Point;
		
		public function Node(xArrayPos:int, yArrayPos:int)
		{
			this.f = 0;
			this.g = 0;
			this.h = 0;
			this.moveable = true;
			
			this.x = xArrayPos;
			this.y = yArrayPos;
			
			this.position = new Point(0,0);
		}
	}
}
