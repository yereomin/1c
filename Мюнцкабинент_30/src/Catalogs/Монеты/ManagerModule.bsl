#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ПрограммныйИнтерфейс
// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати – ТаблицаЗначений – состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	КомандаПечати 									= КомандыПечати.Добавить();
  	КомандаПечати.МенеджерПечати 					= "Справочник.Монеты";
  	КомандаПечати.Идентификатор 					= "ПФ_КарточкаМонеты";
  	КомандаПечати.Представление 					= НСтр("ru = 'Печать карточки'");
  	КомандаПечати.ПроверкаПроведенияПередПечатью 	= Ложь;
	КомандаПечати.Картинка 							= БиблиотекаКартинок.ФорматMXL;
	//КомандаПечати.Обработчик 						= "Справочники.СертификатыИДекларации.ПечатьСертификационныхДокументов";
	
КонецПроцедуры
#КонецОбласти	
	
Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(
				КоллекцияПечатныхФорм, 
				"ПФ_КарточкаМонеты", 
				"Печать карточки",
				ПечатьКарточки(МассивОбъектов, ОбъектыПечати, ПараметрыПечати),
				,
				"Справочник.Монеты.ПФ_MXL_КарточкаМонеты");
	
КонецПроцедуры	

Функция ПечатьКарточки(МассивОбъектов, ОбъектыПечати, ПараметрыПечати, ИмяМакета = "") Экспорт
	
	Если ПустаяСтрока (ИмяМакета) Тогда
		ИмяМакета = "ПФ_MXL_КарточкаМонеты"
	КонецЕсли; 	
	
	УстановитьПривилегированныйРежим(Истина);
	
	Макет = ПолучитьМакет(ИмяМакета);	
	
	ТабДокумент = Новый ТабличныйДокумент;
	
	// Зададим параметры макета
	ТабДокумент.ПолеСверху              = 10;
	ТабДокумент.ПолеСлева               = 15;
	ТабДокумент.ПолеСнизу               = 10;
	ТабДокумент.ПолеСправа              = 10;
	ТабДокумент.РазмерКолонтитулаСверху = 0;
	ТабДокумент.РазмерКолонтитулаСнизу  = 0;
	ТабДокумент.АвтоМасштаб             = Истина;
	ТабДокумент.ОриентацияСтраницы      = ОриентацияСтраницы.Портрет;
	
	ТабДокумент.ИмяПараметровПечати  				= "КАРТОЧКА_МОНЕТЫ";
	
	Макет 									= ПолучитьМакет(ИмяМакета); 
	//
    ВыводитьКартинки 						= Истина;
	//
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	СписокМонет.Ссылка КАК Монета,
		|	СписокМонет.Код КАК Код,
		|	СписокМонет.Наименование КАК Наименование,
		|	СписокМонет.Сохранность КАК Сохранность,
		|	СписокМонет.СохранностьНаименование КАК СохранностьНаименование,
		|	СписокМонет.ФактическийВес КАК ФактическийВес,
		|	СписокМонет.Комментарий КАК Комментарий,
		|	СписокМонет.Коллекционер КАК Коллекционер,
		|	ВидыМонет.Ссылка КАК ВидМонеты,
		|	ВидыМонет.Гурт КАК Гурт,
		|	ВидыМонет.ГодВыпуска КАК ГодВыпуска,
		|	ВидыМонет.Металл КАК Металл,
		|	ВидыМонет.Тираж КАК Тираж,
		|	ВидыМонет.МонетныйДвор КАК МонетныйДвор,
		|	ВидыМонет.Минцмейстер КАК Минцмейстер,
		|	СписокМонет.Коллекция КАК Коллекция,
		|	СписокМонет.Стоимость КАК Стоимость,
		|	СписокМонет.НомерЯчейки КАК НомерЯчейки,
		|	ВидыМонет.ДополнительныеРеквизиты.(
		|		Ссылка КАК Ссылка,
		|		НомерСтроки КАК НомерСтроки,
		|		Свойство КАК Свойство,
		|		Значение КАК Значение,
		|		ТекстоваяСтрока КАК ТекстоваяСтрока
		|	) КАК ДополнительныеРеквизиты
		|ИЗ
		|	(ВЫБРАТЬ
		|		Монеты.Ссылка КАК Ссылка,
		|		Монеты.Код КАК Код,
		|		Монеты.Наименование КАК Наименование,
		|		Монеты.Сохранность КАК Сохранность,
		|		Монеты.Сохранность.Наименование КАК СохранностьНаименование,
		|		Монеты.ФактическийВес КАК ФактическийВес,
		|		Монеты.Комментарий КАК Комментарий,
		|		Монеты.Коллекционер КАК Коллекционер,
		|		ДвиженияМонетОстатки.Коллекция КАК Коллекция,
		|		ДвиженияМонетОстатки.СтоимостьОстаток КАК Стоимость,
		|		НомерВКоллекции.Номер КАК НомерЯчейки
		|	ИЗ
		|		Справочник.Монеты КАК Монеты
		|			ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.ДвиженияМонет.Остатки КАК ДвиженияМонетОстатки
		|			ПО Монеты.Ссылка = ДвиженияМонетОстатки.Объект
		|			ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.НомерВКоллекции КАК НомерВКоллекции
		|			ПО Монеты.Ссылка = НомерВКоллекции.Монета
		|	ГДЕ
		|		Монеты.Ссылка В(&МассивОбъектов)) КАК СписокМонет
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ВидыМонет КАК ВидыМонет
		|		ПО СписокМонет.Ссылка.ВидМонеты = ВидыМонет.Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	Файлы.Ссылка КАК ФайлСсылка,
		|	Файлы.ВладелецФайла КАК Монета
		|ИЗ
		|	Справочник.Файлы КАК Файлы
		|ГДЕ
		|	Файлы.ВладелецФайла В(&МассивОбъектов)";
	
	Запрос.УстановитьПараметр("МассивОбъектов", МассивОбъектов);
	
	МассивРезультатов = Запрос.ВыполнитьПакет();
	
	Шапка 			= МассивРезультатов [0].Выбрать();
	ФайлыКартинок	= МассивРезультатов [1].Выбрать();
	
    ПервыйДокумент = Истина;
    Пока Шапка.Следующий() Цикл
        Если Не ПервыйДокумент Тогда
            // Все документы нужно выводить на разных страницах.
            ТабДокумент.ВывестиГоризонтальныйРазделительСтраниц();
			//
			ФайлыКартинок.Сбросить();
        КонецЕсли;
        ПервыйДокумент 	= Ложь;
        // Запомним номер строки, с которой начали выводить текущий документ.
        НомерСтрокиНачало = ТабДокумент.ВысотаТаблицы + 1;
		//
		// непосредственно вывод
		ОбластьМакета	= Макет.ПолучитьОбласть("Заголовок");
		ОбластьМакета.Параметры.Заполнить(Шапка);

		ТабДокумент.Вывести(ОбластьМакета);
		//
		// доп. реквизиты
		ДопРеквизиты = Шапка.ДополнительныеРеквизиты.Выбрать();
		СтруктураДопРеквизитов = Новый Структура;
		Пока ДопРеквизиты.Следующий () Цикл
			СтруктураДопРеквизитов.Вставить(ДопРеквизиты.Свойство.Имя, ДопРеквизиты.Значение);	
		КонецЦикла;	
		
		ОбластьМакета	= Макет.ПолучитьОбласть("Шапка");
		ОбластьМакета.Параметры.Заполнить(Шапка);
		ОбластьМакета.Параметры.Заполнить(СтруктураДопРеквизитов);
		
		ТабДокумент.Вывести(ОбластьМакета);
		//
		ОбластьМакета	= Макет.ПолучитьОбласть("Альбом");
		ОбластьМакета.Параметры.Заполнить(Шапка);
		ТабДокумент.Вывести(ОбластьМакета);
		
		// вывод картинок
		МассивКартинок = Новый Массив;
		Пока ФайлыКартинок.Следующий () Цикл
			Если ФайлыКартинок.Монета = Шапка.Монета Тогда
				МассивКартинок.Добавить(ФайлыКартинок.ФайлСсылка);	
			КонецЕсли;	
		КонецЦикла;
		//
		КоличествоКартинок 		= МассивКартинок.Количество ();
		КоличествоКолонок		= 2;
		КоличествоСтрок			= Цел(КоличествоКартинок / КоличествоКолонок) + ?(КоличествоКартинок % КоличествоКолонок = 0, 0, 1);
		НачальныйНомерКартинки 	= 0;
		//
		Для СчСтр = 0 По КоличествоСтрок - 1 Цикл
			
			ОбластьКартинки = Макет.ПолучитьОбласть ("Изображения");
			//
			КонечныйНомерКартинки = ?(НачальныйНомерКартинки + КоличествоКолонок - 1 < КоличествоКартинок - 1, НачальныйНомерКартинки + КоличествоКолонок - 1, КоличествоКартинок - 1);
			Для Сч = НачальныйНомерКартинки По КонечныйНомерКартинки Цикл
				
				Если Сч % 2 = 0 Тогда
					ЯчейкаКартинки = ОбластьКартинки.Области.ЛеваяКартинка;	
				Иначе
					ЯчейкаКартинки = ОбластьКартинки.Области.ПраваяКартинка;
				КонецЕсли;	
				
				ЯчейкаКартинки.Картинка = Новый Картинка (РаботаСФайлами.ДвоичныеДанныеФайла(МассивКартинок [Сч]));
				
			КонецЦикла;	
			
			НачальныйНомерКартинки = НачальныйНомерКартинки + КоличествоКолонок;
			//
			ТабДокумент.Вывести(ОбластьКартинки);
				
		КонецЦикла;	
		
		// подвал
		ОбластьМакета	= Макет.ПолучитьОбласть("Подвал");
		ОбластьМакета.Параметры.Заполнить(Шапка);

		ТабДокумент.Вывести(ОбластьМакета);
		//
		
        // В табличном документе необходимо задать имя области, в которую был 
        // выведен объект. Нужно для возможности печати комплектов документов.
        УправлениеПечатью.ЗадатьОбластьПечатиДокумента(ТабДокумент, 
            НомерСтрокиНачало, ОбъектыПечати, Шапка.Монета);
	КонецЦикла;	
	//
	Возврат ТабДокумент;
	
КонецФункции

#КонецЕсли