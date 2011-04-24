package com.behindcurtain3.astar
{

	import flash.geom.Point;
	import mx.collections.*;

	public class AStar
	{
		private var pathNodes:Array;
		
		public function AStar()
		{
			pathNodes = new Array();
		}
		
		public function clearNodes():void
		{
			pathNodes.clear();
		}
		
		public function addNode(node:Node):void
		{
			pathNodes.push(node);
		}
		
		public function setNodes(nodes:Array):void
		{
			pathNodes = nodes;
		}
		
		public function getPath(start:Point, target:Point):Array
		{	
			//trace("A* - Generating Path from {"+start.x+","+start.y+"} to {"+target.x+","+target.y+"}");
			var openlist:ArrayCollection = new ArrayCollection();	// Holds open nodes
			var closedlist:ArrayCollection = new ArrayCollection();	// Holds closed nodes
			var foundTarget:Boolean = false;
			var currentNode:Node;
				
			// STEP 1: Add the starting node to the open list
			//trace("DEBUG - Add to open list pathfindingNodes[" + x + "][" + y + "]");
			pathNodes[start.x][start.y].parent = null;
			openlist.addItem(pathNodes[start.x][start.y]);
			
			// STEP 2: Repeat search
			while(!foundTarget)
			{
				// If the openlist has no nodes in it we didn't find a path, return empty array
				if(openlist.length == 0)
					return null;
				
				// STEP 2A: Get lowest cost f score from open list
				var lowestFScore:Number = 99999;
				var nodeIndex:int;
				for(var i:int = 0; i < openlist.length; i++)
				{
					if(openlist[i].f < lowestFScore)
					{
						lowestFScore = openlist[i].f;
						currentNode = openlist[i];
						nodeIndex = i;
					}
				}
				
				// If the currentNode is the target(!!) we found our path
				if(currentNode.x == target.x && currentNode.y == target.y)
				{
					foundTarget = true;
					
					// STEP 3: Generate the path
					// Start with the target and go backwards using .parent
					var path:Array = new Array();
					var pathNode:Node = currentNode;
					while(pathNode.parent != null)
					{
						path.push(pathNode);
						pathNode = pathNode.parent;
					}
					return path;	// return the array full of nodes to traverse
				}
				
				// STEP 2B: Switch currentNode to the closedlist
				openlist.removeItemAt(nodeIndex);
				closedlist.addItem(currentNode);
				
				// STEP 2C: Check neighbors nodes, add them to the openlist if 1) They are moveable 2) They AREN'T on the closedlist 3) They aren't already on the openlist				
				// Next, if we are going to add a neighbor to the openlist then make the currentNode the parent of the neighbor
				var neighbors:Array = new Array();
				
				// NORTH
				if(currentNode.y > 0) // Don't add the north node if y == 0 since there isn't one
				{
					neighbors.push(pathNodes[currentNode.x][currentNode.y - 1]);
				}
				
				// SOUTH
				if(currentNode.y < pathNodes[0].length - 1) // Don't add the south node if y == bottom row since there isn't one
				{
					neighbors.push(pathNodes[currentNode.x][currentNode.y + 1]);
				}
				
				// EAST
				if(currentNode.x < pathNodes.length - 1) // Don't add the east node if x == right column since there isn't one
				{
					neighbors.push(pathNodes[currentNode.x + 1][currentNode.y]);
				}
				
				// WEST
				if(currentNode.x > 0) // Same as usual
				{
					neighbors.push(pathNodes[currentNode.x - 1][currentNode.y]);
				}
				
				for each(var index:Node in neighbors)
				{
					if(index.moveable && !closedlist.contains(index))
					{
						if(openlist.contains(index))
						{
						}
						else
						{
							index.parent = currentNode;
							index.g = index.parent.g + 10;
							index.h = Math.abs(index.x - target.x) + Math.abs(index.y - target.y);
							index.f = index.g + index.h;
							openlist.addItem(index);
						}
					}
				}
				// END STEP 2C
			} // END WHILE LOOP
			return new Array();
		}
	}
}
