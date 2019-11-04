// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Объект, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды


&НаКлиенте
Процедура ПересчитатьСуммуИздержек (Элемент)
	//
	ПересчитатьСуммуИздержекНаСервере ();
	//
	//ЭтаФорма.ТекущийЭлемент = Элемент;
	//
КонецПроцедуры	

&НаСервере
Процедура ПересчитатьСуммуИздержекНаСервере ()
	//
	Если Элементы.Список.ТекущаяСтрока = Неопределено Тогда
		Возврат
	КонецЕсли;	
	
	СтрокаКоллекции = Объект.Список.НайтиПоИдентификатору(Элементы.Список.ТекущаяСтрока);
	ИндексСтрокиКоллекции = Объект.Список.Индекс(СтрокаКоллекции);
	//
	ТмпТЗ = Объект.Список.Выгрузить ();
	//
	СтрокаВыгруженнойТаблицы = ТмпТЗ.Получить(ИндексСтрокиКоллекции);
	//
	ТмпТЗ.Колонки.Добавить("СуммаБезИздержек", Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(15, 2)));
	Для Каждого Строка ИЗ ТмпТЗ Цикл
		Строка.СуммаБезИздержек 				= Строка.Цена * ?(Строка.Количество > 0, Строка.Количество, 1)
	КонецЦикла;	
	//
	ИтогоСуммаБезИздержек					= ТмпТЗ.Итог("СуммаБезИздержек");
	//
	Сч 											= 0; 
	СуммаРаспределенныхРасходов 				= 0;
	КоличествоСтрок 							= ТмпТЗ.Количество();
	
	Для Каждого Строка ИЗ ТмпТЗ Цикл
		Сч = Сч + 1;
		//
		Если Сч = КоличествоСтрок Тогда
			Строка.Издержки 					= Объект.НакладныеРасходы - СуммаРаспределенныхРасходов;
		Иначе	
			Строка.Издержки 					= Строка.СуммаБезИздержек / ИтогоСуммаБезИздержек * Объект.НакладныеРасходы;
			СуммаРаспределенныхРасходов 		= СуммаРаспределенныхРасходов + Строка.Издержки;
		КонецЕсли;	
		
		Строка.Сумма							= Строка.Издержки + Строка.СуммаБезИздержек;
		
	КонецЦикла;	
	//
	ИндексСтрокиПослеПересчета = ТмпТЗ.Индекс(СтрокаВыгруженнойТаблицы);
	//
	Объект.Список.Загрузить(ТмпТЗ);
	//
	СтрокаКоллекции = Объект.Список.Получить(ИндексСтрокиПослеПересчета);
	Элементы.Список.ТекущаяСтрока = СтрокаКоллекции.ПолучитьИдентификатор();
	//
КонецПроцедуры


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда // новый
		Объект.Дата									= ТекущаяДата();
		Объект.ТипЦены								= Справочники.ТипыЦен.ЦенаПриобретения;
		Объект.НакладныеРасходыУвеличиваютСтоимость = Истина;
	КонецЕсли;	
	
  	// СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура НакладныеРасходыПриИзменении(Элемент)
	//
	ПересчитатьСуммуИздержек (Элемент);
	//
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УправлениеВидимостьюРеквизитовКоллекция ();
	УправлениеВидимостьюКолонкиИздержки ();
	
	ОсновнаяУчетнаяВалюта = ПолучитьОсновнуюУчетнуюВалюту ();
	Если ОсновнаяУчетнаяВалюта.Пустая () Тогда
		ТекстПояснения = НСтр("ru = 'Не установлена основная учетная валюта.'"); 
		ПоказатьОповещениеПользователя(НСтр("ru = 'Установите учетные валюты!'"),
			"e1cib/app/ОбщаяФорма.ФормаВалютныхКонстант", ТекстПояснения, БиблиотекаКартинок.Предупреждение32);
	КонецЕсли;
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Функция ПолучитьОсновнуюУчетнуюВалюту ()

	Возврат Константы.ОсновнаяУчетнаяВалюта.Получить()

КонецФункции // ПолучитьОсновнуюУчетнуюВалюту ()()

&НаКлиенте
Процедура СписокПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	Если НоваяСтрока Тогда
		Элемент.ТекущиеДанные.Количество = 1
	КонецЕсли;	
КонецПроцедуры

&НаКлиенте
Процедура РазличныеКоллекцииПриИзменении(Элемент)
	УправлениеВидимостьюРеквизитовКоллекция ()
КонецПроцедуры

&НаКлиенте
Процедура УправлениеВидимостьюРеквизитовКоллекция ()
	
	Элементы.Коллекция.Видимость 		= НЕ Объект.РазличныеКоллекции;
	Элементы.СписокКоллекция.Видимость 	= Объект.РазличныеКоллекции;
	//
	Если Объект.РазличныеКоллекции Тогда
		Объект.Коллекция				= ПредопределенноеЗначение("Справочник.Коллекции.ПустаяСсылка");
	КонецЕсли;
КонецПроцедуры	

&НаКлиенте
Процедура УправлениеВидимостьюКолонкиИздержки ()
	
	Элементы.СписокИздержки.Видимость = Объект.НакладныеРасходыУвеличиваютСтоимость;
	
КонецПроцедуры	

&НаКлиенте
Процедура СписокЦенаПриИзменении(Элемент)
	//
	ПересчитатьСуммуИздержек (Элемент);
	//
КонецПроцедуры

&НаСервере
Процедура ЗаписатьКомментарийНаСервере(Знач Примечание)
	Для Каждого Строка ИЗ Объект.Список Цикл
		МонетаОбъект 		= Строка.Монета.ПолучитьОбъект ();
		ПримечаниеМонеты 	= МонетаОбъект.Комментарий;
		Если Найти (ПримечаниеМонеты, Примечание) = 0 Тогда
			ПримечаниеМонеты = ?(ПустаяСтрока (ПримечаниеМонеты), Примечание, ПримечаниеМонеты + " (" + Примечание + ")");
		КонецЕсли;
		МонетаОбъект.Комментарий = ПримечаниеМонеты;
		Попытка
			МонетаОбъект.Записать ();
		Исключение
        	Продолжить
		КонецПопытки;	
	КонецЦикла;	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьКомментарий(Команда)
	ЗаписатьКомментарийНаСервере(Объект.Комментарий);
КонецПроцедуры

&НаКлиенте
Процедура НакладныеРасходыУвеличиваютСтоимостьПриИзменении(Элемент)
	Если Объект.НакладныеРасходыУвеличиваютСтоимость Тогда
		
		ПересчитатьСуммуИздержек (Элемент);		
		
	Иначе
		Для Каждого Строка ИЗ Объект.Список Цикл
			Строка.Издержки = 0;
			Строка.Сумма 	= ?(Строка.Количество = 0, 1, Строка.Количество) * Строка.Цена;
		КонецЦикла;	
	КонецЕсли;	
	
	УправлениеВидимостьюКолонкиИздержки ();
	
КонецПроцедуры

&НаКлиенте
Процедура СписокКоличествоПриИзменении(Элемент)
	//
	ПересчитатьСуммуИздержек (Элемент);
	//
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Отказ = МонетыУжеЕстьНаОстатках ();
	
КонецПроцедуры

Функция МонетыУжеЕстьНаОстатках ()
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	ТмпТЗ = Объект.Список.Выгрузить (, "НомерСтроки,Монета");
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ТЗ.НомерСтроки,
		|	ТЗ.Монета
		|ПОМЕСТИТЬ Монеты
		|ИЗ
		|	&ТпмТЗ КАК ТЗ
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	Монеты.НомерСтроки,
		|	ДвиженияМонетОстаткиИОбороты.Объект КАК Монета,
		|	ДвиженияМонетОстаткиИОбороты.Коллекция,
		|	ДвиженияМонетОстаткиИОбороты.Регистратор,
		|	ДвиженияМонетОстаткиИОбороты.КоличествоКонечныйОстаток КАК Количество
		|ИЗ
		|	Монеты КАК Монеты
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.ДвиженияМонет.ОстаткиИОбороты(, , Регистратор, , ) КАК ДвиженияМонетОстаткиИОбороты
		|		ПО Монеты.Монета = ДвиженияМонетОстаткиИОбороты.Объект
		|ГДЕ
		|	ДвиженияМонетОстаткиИОбороты.Регистратор <> &Регистратор
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|УНИЧТОЖИТЬ Монеты";
	
	Запрос.УстановитьПараметр("Регистратор", Объект.Ссылка);
	Запрос.УстановитьПараметр("ТпмТЗ", ТмпТЗ);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Если Выборка.Следующий() Тогда
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Cтрока %1: %2 уже в коллекции %3! Регистратор: %4'"), Выборка.НомерСтроки, Выборка.Монета, Выборка.Коллекция, Выборка.Регистратор);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , "Список [" + Выборка.НомерСтроки + "]" + ".Монета", "Объект");
		Возврат Истина
	Иначе
		Возврат Ложь
	КонецЕсли;
	
КонецФункции	

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры


