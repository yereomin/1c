
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("ГодВыпуска") Тогда
		Список.Параметры.УстановитьЗначениеПараметра("ГодВыпуска", Параметры.ГодВыпуска);
	КонецЕсли;	
КонецПроцедуры
