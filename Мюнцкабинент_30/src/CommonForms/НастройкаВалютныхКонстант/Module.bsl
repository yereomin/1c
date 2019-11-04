
&НаКлиенте
Процедура ОткрытьФормуВалютныхКонстантНажатие(Элемент)
	
	ОткрытьФорму("ОбщаяФорма.ФормаВалютныхКонстант",,ЭтаФорма,УникальныйИдентификатор)
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ПоказатьПредупреждающуюНадпись ()
	
КонецПроцедуры

&НаСервере
Процедура ПоказатьПредупреждающуюНадпись ()
	
	ОсновнаяУчетнаяВалюта = Константы.ОсновнаяУчетнаяВалюта.Получить();
	Элементы.КонстантыНеНастроены.Видимость = ОсновнаяУчетнаяВалюта.Пустая()
	
КонецПроцедуры	

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "ЗакрытаФормаНастройкиВалютныхКонстант" Тогда
		ПоказатьПредупреждающуюНадпись ()
	КонецЕсли;	
КонецПроцедуры
