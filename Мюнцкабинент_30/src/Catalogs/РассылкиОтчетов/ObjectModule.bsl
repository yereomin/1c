#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	// Вызывается непосредственно до записи объекта в базу данных.
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	Если ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;
	
	// Создание регламентного задания - пустышки (для хранения его идентификатора в данных).
	УстановитьПривилегированныйРежим(Истина);
	Задание = РегламентныеЗаданияСервер.Задание(РегламентноеЗадание);
	
	Если Задание = Неопределено Тогда
		ПараметрыЗадания = Новый Структура("Использование, ИмяПользователя, Наименование");
		ПараметрыЗадания.Вставить("Метаданные",      Метаданные.РегламентныеЗадания.РассылкаОтчетов);
		ПараметрыЗадания.Вставить("ИмяПользователя", РассылкаОтчетов.ИмяПользователяИБ(Автор));
		ПараметрыЗадания.Вставить("Использование",   Ложь);
		ПараметрыЗадания.Вставить("Наименование",    ПредставлениеЗаданияПоРассылке(Наименование));
		
		Задание = РегламентныеЗаданияСервер.ДобавитьЗадание(ПараметрыЗадания);
		РегламентноеЗадание = Задание.УникальныйИдентификатор;
	КонецЕсли;
	УстановитьПривилегированныйРежим(Ложь);
	
	// Соответствие флага подготовленности рассылки и задания пометке удаления рассылки.
	Если ПометкаУдаления И Подготовлена Тогда
		Подготовлена = Ложь;
	КонецЕсли;
	
	// Соответствие группы признаку личной рассылки по электронной почте.
	// Пользовательские проверки расположены в форме элемента.
	// Эти проверки обеспечивают жесткие привязки.
	ВыбранаГруппаЛичныхРассылок = (Родитель = Справочники.РассылкиОтчетов.ЛичныеРассылки);
	Если Личная <> ВыбранаГруппаЛичныхРассылок Тогда
		Родитель = ?(Личная, Справочники.РассылкиОтчетов.ЛичныеРассылки, Справочники.РассылкиОтчетов.ПустаяСсылка());
	КонецЕсли;
КонецПроцедуры

Процедура ПередУдалением(Отказ)
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	Если ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;
	
	Задание = РегламентныеЗаданияСервер.Задание(РегламентноеЗадание);
	Если Задание <> Неопределено Тогда
		Задание.Удалить();
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	ОбщегоНазначения.УдалитьДанныеИзБезопасногоХранилища(Ссылка);
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	Если ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;
	
	РегламентноеЗадание = Неопределено;
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	// Вызывается непосредственно после записи объекта в базу данных.
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	Если ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	Задание = РегламентныеЗаданияСервер.Задание(РегламентноеЗадание);
	Если Задание <> Неопределено Тогда
		ЗаданиеИзменено = Ложь;
		
		ВключитьЗадание = ВыполнятьПоРасписанию И Подготовлена;
		Если Задание.Использование <> ВключитьЗадание Тогда
			Задание.Использование = ВключитьЗадание;
			ЗаданиеИзменено = Истина;
		КонецЕсли;
		
		// Расписание устанавливается в форме элемента.
		Если ДополнительныеСвойства.Свойство("Расписание") 
			И ТипЗнч(ДополнительныеСвойства.Расписание) = Тип("РасписаниеРегламентногоЗадания")
			И Строка(ДополнительныеСвойства.Расписание) <> Строка(Задание.Расписание) Тогда
			Задание.Расписание = ДополнительныеСвойства.Расписание;
			ЗаданиеИзменено = Истина;
		КонецЕсли;
		
		ИмяПользователя = РассылкаОтчетов.ИмяПользователяИБ(Автор);
		Если Задание.ИмяПользователя <> ИмяПользователя Тогда
			Задание.ИмяПользователя = ИмяПользователя;
			ЗаданиеИзменено = Истина;
		КонецЕсли;
		
		НаименованиеЗадания = ПредставлениеЗаданияПоРассылке(Наименование);
		Если Задание.Наименование <> НаименованиеЗадания Тогда
			Задание.Наименование = НаименованиеЗадания;
			ЗаданиеИзменено = Истина;
		КонецЕсли;
		
		Если Задание.Параметры.Количество() <> 1 ИЛИ Задание.Параметры[0] <> Ссылка Тогда
			ПараметрыЗадания = Новый Массив;
			ПараметрыЗадания.Добавить(Ссылка);
			Задание.Параметры = ПараметрыЗадания;
			ЗаданиеИзменено = Истина;
		КонецЕсли;
			
		Если ЗаданиеИзменено Тогда
			Задание.Записать();
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПредставлениеЗаданияПоРассылке(НаименованиеРассылки)
	Возврат СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Рассылка отчетов: %1'"), СокрЛП(НаименованиеРассылки));
КонецФункции

#КонецОбласти

#КонецЕсли
