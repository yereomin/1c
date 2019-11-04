
Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если НЕ ЗначениеЗаполнено(Коллекционер) Тогда
		Коллекционер = ПараметрыСеанса.ТекущийПользователь;
	КонецЕсли;	
	
	СуммаДокумента = Список.Итог("Сумма");
	//
	КоллекцииСтрокой = СформироватьСписокКоллекций ();
	//
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, Режим)
	
	// регистр ДвиженияМонет Приход
	Движения.ДвиженияМонет.Записывать = Истина;
	Для Каждого ТекСтрокаСписок Из Список Цикл
		Движение 				= Движения.ДвиженияМонет.Добавить();
		Движение.ВидДвижения 	= ВидДвиженияНакопления.Приход;
		Движение.Период 		= Дата;
		Движение.Объект 		= ТекСтрокаСписок.Монета;
		Движение.Коллекция		= ?(РазличныеКоллекции, ТекСтрокаСписок.Коллекция, Коллекция);
		Движение.Количество		= ?(ТекСтрокаСписок.Количество > 0, ТекСтрокаСписок.Количество, 1);
		Движение.Стоимость		= ?(Движение.Количество <> 0, ТекСтрокаСписок.Сумма / Движение.Количество, ТекСтрокаСписок.Сумма);
	КонецЦикла;
	//
	// регистр Поступление монет
	Движения.ПоступлениеМонет.Записывать	= Истина;
	Для Каждого ТекСтрокаСписок Из Список Цикл
		Движение 				= Движения.ПоступлениеМонет.Добавить();
		Движение.Период 		= Дата;
		Движение.Объект 		= ТекСтрокаСписок.Монета;
		Движение.Валюта 		= ТипЦены.Валюта;
		Движение.Коллекция		= ?(РазличныеКоллекции, ТекСтрокаСписок.Коллекция, Коллекция);
		Движение.Количество		= ?(ТекСтрокаСписок.Количество > 0, ТекСтрокаСписок.Количество, 1);
		Движение.Сумма 			= ТекСтрокаСписок.Сумма;
	КонецЦикла;	
	//
	РегистрыСведений.СтоимостьОбъектовКоллекцинирования.УдалитьЗаписиПоРегистраторуЦен(Ссылка);
	
	// регистр СтоимостьОбъектовКоллекцинирования
	Для Каждого Строка Из Список Цикл
		МЗ = РегистрыСведений.СтоимостьОбъектовКоллекцинирования.СоздатьМенеджерЗаписи();
		МЗ.Период				= Дата;
		МЗ.Объект 				= Строка.Монета;
		МЗ.ТипЦены				= ТипЦены;
		МЗ.Стоимость			= ?(Строка.Количество <> 0, Строка.Сумма/Строка.Количество, Строка.Сумма);
		МЗ.РегистраторЦен		= Ссылка;
		МЗ.Записать();
	КонецЦикла;	
	
	// регистр ДополнительныеРасходы Приход
	Если (НЕ НакладныеРасходыУвеличиваютСтоимость) И (НакладныеРасходы <> 0) Тогда
		// если накладные расходы не учитываются в стоимости монет, то просто учтем их как доп. расходы
		
		Движения.ДополнительныеРасходы.Записывать = Истина;
		Движение = Движения.ДополнительныеРасходы.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Период = Дата;
		Движение.Коллекционер = Коллекционер;
		Движение.Сумма = НакладныеРасходы;
		
	КонецЕсли;	
	
	
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	Если ПроверяемыеРеквизиты.Найти ("ТипЦены") = Неопределено Тогда
		ПроверяемыеРеквизиты.Добавить ("ТипЦены")	
	КонецЕсли;	
КонецПроцедуры

Функция СформироватьСписокКоллекций () Экспорт
	Если Не РазличныеКоллекции Тогда
		Возврат СокрЛП(Коллекция.Наименование);
	Иначе
		ТмпТЗ = Список.Выгрузить(, "Коллекция");
		ТмпТЗ.Свернуть("Коллекция", "");
		ТмпСтр = "";
		Для Каждого Строка ИЗ ТмпТЗ Цикл
			ТмпСтр = ?(ПустаяСтрока(ТмпСтр), "", ТмпСтр + "; ") + СокрЛП(Строка.Коллекция.Наименование) 
		КонецЦикла;	
		Возврат ТмпСтр 
	КонецЕсли;	
КонецФункции	

