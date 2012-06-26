package math 
{
	import flash.geom.Point;
	/**
	 * Класс предназначен для перевода математических точек из одной координатной системы в другую.
	 * Следует применять при преобразовании пикселей на сцене в ячейки на карте тайлов и наоборот.
	 * Номер колонки (координата X) на тайловой сетке (карта ячеек) - это номер ячейки, считаемый от
	 * левой ячейки покрывающего ромба ячеек в его верхнюю серединную ячейку.
	 * Номер строки (координата Y) на тайловой сетке - это номер ячейки, считаемый от
	 * левой ячейки покрывающего ромба ячеек в его нижнюю серединную ячейку.
	 * Это означает, что ячейки имеют левый (против часовой стрелки) поворот 0-90 градусов относительно
	 * координатной системы отображения объектов, где x-позиция увеличивается при перемещении вправо,
	 * а y-позиция увеличивается при перемещении вниз
	 * ...
	 * @author Alex Sarapulov
	 */
	public class Isometric 
	{
		/**
		 * Ширина изометрической ячейки (пиксели)
		 * 
		 */
		public static var CELL_WIDTH:Number = 100;
		/**
		 * Высота изометрической ячейки (пиксели)
		 * 
		 */
		public static var CELL_HEIGHT:Number = 50;
		
		/**
		 * Максимальная ширина изометрической карты ячеек(пиксели),
		 * должна соответствовать пропорциям ячейки
		 * 
		 */
		public static var MAP_WIDTH:Number = 4096;
		/**
		 * Максимальная высота изометрической карты ячеек (пиксели)
		 * 
		 */
		public static var MAP_HEIGHT:Number = 2048;
		
		/**
		 * Отступ карты ячеек от рамки координатной области справа и слева (пиксели)
		 * 
		 */
		public static var PADDING_X:Number = 200;
		/**
		 * Отступ карты ячеек от рамки координатной области сверху и снизу (пиксели)
		 * 
		 */
		public static var PADDING_Y:Number = 200;
		
		/**
		 * Перевод координат из координатной системы ячеек (номера ячеек) в координатную систему
		 * их изометрических отображений (пиксели на плоскости изометрической проекции)
		 * 
		 * @param	xpos Позиция ячейки X (номер колонки ячеек в двумерной матрице карты) 
		 * @param	ypos Позиция ячейки Y (номер строки ячеек в двумерной матрице карты) 
		 * @return Позиция в изометрической системе координат (количество пикселей по X оси и
		 * количество пикселей по Y оси в плоскости изометрической проекции)
		 * 
		 */
		public static function normalToIsometric(xpos:int, ypos:int):Point
		{
			var res:Point = new Point();
			res.x = CELL_WIDTH / 2 * Number(ypos + xpos) + PADDING_X;
			res.y = CELL_HEIGHT / 2 * Number(ypos - xpos) + PADDING_Y + MAP_HEIGHT / 2;
			return res;
		}
		
		/**
		 * Перевод координат из координатной системы изометрических отображений (пиксели на плоскости изометрической проекции)
		 * в координатную систему ячеек двумерной матрицы карты (номера ячеек)
		 * 
		 * @param	ix Номер пикселя по оси X в изометрической системе координат (смещение от начала координат изометрической проекции)
		 * @param	iy Номер пикселя по оси Y в изометрической системе координат (смещение от начала координат изометрической проекции)
		 * @return Позиция ячейки в двумерной матрице карты ячеек (x, y). x - это номер колонки, а y - это номер строки
		 * 
		 */
		public static function isometricToNormal(ix:Number, iy:Number):Point
		{
			ix -= PADDING_X;
			iy -= PADDING_Y + MAP_HEIGHT / 2;
			var res:Point = new Point();
			res.x = Math.floor(ix / CELL_WIDTH - iy / CELL_HEIGHT);
			res.y = Math.floor(ix / CELL_WIDTH + iy / CELL_HEIGHT);
			return res;
		}
	}

}