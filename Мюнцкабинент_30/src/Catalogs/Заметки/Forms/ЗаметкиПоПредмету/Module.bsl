
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Если Параметры.Свойство("Предмет") Тогда 
		Предмет = Параметры.Предмет;
		Список.Параметры.УстановитьЗначениеПараметра("Предмет", Предмет);
	КонецЕсли;
	
	Список.Параметры.УстановитьЗначениеПараметра("Пользователь", Пользователи.ТекущийПользователь());
	Список.Параметры.УстановитьЗначениеПараметра("ПоказыватьЗаметкиДругихПользователей", Ложь);
	Список.Параметры.УстановитьЗначениеПараметра("ПоказыватьУдаленные", Ложь);
	
	Если Не Пользователи.ЭтоПолноправныйПользователь() Тогда
		Элементы.Автор.Видимость = Ложь;
		Элементы.ПоказыватьЗаметкиДругихПользователей.Видимость = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	Список.Параметры.УстановитьЗначениеПараметра("ПоказыватьЗаметкиДругихПользователей", ПоказыватьЗаметкиДругихПользователей);
	Список.Параметры.УстановитьЗначениеПараметра("ПоказыватьУдаленные", ПоказыватьУдаленные);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПоказыватьЗаметкиДругихПользователейПриИзменении(Элемент)
	Список.Параметры.УстановитьЗначениеПараметра("ПоказыватьЗаметкиДругихПользователей", ПоказыватьЗаметкиДругихПользователей);
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьУдаленныеПриИзменении(Элемент)
	Список.Параметры.УстановитьЗначениеПараметра("ПоказыватьУдаленные", ПоказыватьУдаленные);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТаблицыСписок

&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	Если Не Копирование Тогда
		Отказ = Истина;
		ПараметрыФормы = Новый Структура("Предмет", Предмет);
		ОткрытьФорму("Справочник.Заметки.ФормаОбъекта", ПараметрыФормы);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	Список.УсловноеОформление.Элементы.Очистить();
	Элемент = Список.УсловноеОформление.Элементы.Добавить();
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДляРабочегоСтола");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ПометкаУдаления");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("Шрифт", Новый Шрифт(,,Истина));
	
КонецПроцедуры

#КонецОбласти

