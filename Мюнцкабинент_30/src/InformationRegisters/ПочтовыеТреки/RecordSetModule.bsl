
Процедура ПриЗаписи(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка тогда
		Возврат;
	КонецЕсли;
	
	Для Индекс = 0 По ЭтотОбъект.Количество() - 1 Цикл
		Если Найти(ВРег(ЭтотОбъект [Индекс].Операция), ВРег("вручение")) > 0 Тогда
			РегистрыСведений.ПочтовыеИдентификаторы.УстановитьОтметкуОВручении(ЭтотОбъект [Индекс].Документ);	
		КонецЕсли;	
		
		Если Индекс = ЭтотОбъект.Количество() - 1 Тогда // запись последлего статуса
			РегистрыСведений.ПочтовыеИдентификаторы.УстановитьТекущийСтатус (ЭтотОбъект [Индекс].Документ, ЭтотОбъект [Индекс].Статус);		
		КонецЕсли;	
	КонецЦикла;
	
КонецПроцедуры

