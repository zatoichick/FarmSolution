package views.states
{
	import controllers.ClientConnectionController;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import models.Model;
	
	import views.map.MapView;
	import views.panels.GameControlPanel;
	
	// класс игровой страницы
	[Event(name="complete", type="flash.events.Event")]
	public class GameState extends BaseState
	{
		// карта мира
		private var _mapView:MapView;
		// панель управления
		private var _controlPanel:GameControlPanel;
		
		// модель
		private var _model:Model;
		// контроллер
		private var _controller:ClientConnectionController;
		
		// -- конструктор
		public function GameState(stateID:String, holder:DisplayObjectContainer, controller:ClientConnectionController)
		{
			// создание модели
			_model = Model.instance;
			_model.addEventListener(Event.INIT, modelInitHandler);
			_model.init(controller);
			
			// создание визуализации
			_mapView = new MapView(controller, _model.getMapSize());
			_controlPanel = new GameControlPanel(controller, _mapView);
			
			// создание списка активных объектов состояния
			var inners:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			inners.push(_mapView);
			inners.push(_controlPanel);
			
			// получение данных о контроллере
			_controller = controller;
			_controller.getResource("/media/background.jpg", _mapView.setBackgroundTexture);
			
			super(stateID, holder, inners);
		}
		
		// обработчик завершения инициализации модели
		private function modelInitHandler(event:Event):void 
		{
			_mapView.currentUser = _controller.client.currentUser;
		}
		
		// запуск состояния игры
		override public function start():void
		{
			trace(_stateID + " started");
		}
		
		// остановка состояния игры
		override public function stop():void
		{
			trace(_stateID + " stopped");
		}
		
		// обработчик изменения размера контейнера
		override public function resize(width:Number, height:Number):void
		{
			_mapView.resize(width, height);
			_controlPanel.resize(width, height);
		}
	}
}