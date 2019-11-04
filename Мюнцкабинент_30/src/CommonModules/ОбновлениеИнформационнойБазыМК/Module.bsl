Процедура ОбновитьИспользованиеНаборовСвойств() Экспорт
	
	ПараметрыНабора = УправлениеСвойствами.СтруктураПараметровНабораСвойств();
	ПараметрыНабора.Используется = Истина;
	
	УправлениеСвойствами.УстановитьПараметрыНабораСвойств("Справочник_Партнеры", ПараметрыНабора);
	УправлениеСвойствами.УстановитьПараметрыНабораСвойств("Справочник_ВидыМонет", ПараметрыНабора);
	
	
КонецПроцедуры

// Процедура обновления ИБ для справочника видов контактной информации
Процедура КонтактнаяИнформацияОбновлениеИБ() Экспорт
	//
	// Справочник "Контрагенты"
	КонтактнаяИнформацияКонтрагентов = Справочники.ВидыКонтактнойИнформации.СправочникКонтрагенты.ПолучитьОбъект();
    КонтактнаяИнформацияКонтрагентов.Используется 			= Истина;
    ОбновлениеИнформационнойБазы.ЗаписатьДанные(КонтактнаяИнформацияКонтрагентов);
	
    ПараметрыВида = УправлениеКонтактнойИнформацией.ПараметрыВидаКонтактнойИнформации(Перечисления.ТипыКонтактнойИнформации.Адрес);
    ПараметрыВида.Вид 										= Справочники.ВидыКонтактнойИнформации.АдресКонтрагента;
    ПараметрыВида.Используется 								= Истина;
    ПараметрыВида.МожноИзменятьСпособРедактирования 		= Истина;
    ПараметрыВида.Порядок 									= 10;
    ПараметрыВида.НастройкиПроверки.ТолькоНациональныйАдрес = Истина;
    ПараметрыВида.НастройкиПроверки.ПроверятьКорректность 	= Ложь;
    ПараметрыВида.НастройкиПроверки.ПроверятьПоФИАС 		= Истина; // Только для российской версии библиотеки.
    УправлениеКонтактнойИнформацией.УстановитьСвойстваВидаКонтактнойИнформации(ПараметрыВида);
	
    ПараметрыВида = УправлениеКонтактнойИнформацией.ПараметрыВидаКонтактнойИнформации(Перечисления.ТипыКонтактнойИнформации.АдресЭлектроннойПочты);
    ПараметрыВида.Вид 										= Справочники.ВидыКонтактнойИнформации.EmailКонтрагента;
    ПараметрыВида.Используется 								= Истина;
    ПараметрыВида.МожноИзменятьСпособРедактирования 		= Истина;
    ПараметрыВида.Порядок 									= 20;
    //ПараметрыВида.НастройкиПроверки.ТолькоНациональныйАдрес = Истина;
    //ПараметрыВида.НастройкиПроверки.ПроверятьКорректность 	= Истина;
    //ПараметрыВида.НастройкиПроверки.ПроверятьПоФИАС 		= Истина; // Только для российской версии библиотеки.
    УправлениеКонтактнойИнформацией.УстановитьСвойстваВидаКонтактнойИнформации(ПараметрыВида);
	//
	// Справочник "Партнеры"
	КонтактнаяИнформацияПартнеров = Справочники.ВидыКонтактнойИнформации.СправочникПартнеры.ПолучитьОбъект();
    КонтактнаяИнформацияПартнеров.Используется 				= Истина;
    ОбновлениеИнформационнойБазы.ЗаписатьДанные(КонтактнаяИнформацияПартнеров);
	
    ПараметрыВида = УправлениеКонтактнойИнформацией.ПараметрыВидаКонтактнойИнформации(Перечисления.ТипыКонтактнойИнформации.Адрес);
    ПараметрыВида.Вид 										= Справочники.ВидыКонтактнойИнформации.АдресПартнера;
    ПараметрыВида.Используется 								= Истина;
    ПараметрыВида.МожноИзменятьСпособРедактирования 		= Истина;
    ПараметрыВида.Порядок 									= 10;
    ПараметрыВида.НастройкиПроверки.ТолькоНациональныйАдрес = Истина;
    ПараметрыВида.НастройкиПроверки.ПроверятьКорректность 	= Истина;
    ПараметрыВида.НастройкиПроверки.ПроверятьПоФИАС 		= Истина; // Только для российской версии библиотеки.
    УправлениеКонтактнойИнформацией.УстановитьСвойстваВидаКонтактнойИнформации(ПараметрыВида);
	
    ПараметрыВида = УправлениеКонтактнойИнформацией.ПараметрыВидаКонтактнойИнформации(Перечисления.ТипыКонтактнойИнформации.АдресЭлектроннойПочты);
    ПараметрыВида.Вид 										= Справочники.ВидыКонтактнойИнформации.EmailПартнера;
    ПараметрыВида.Используется 								= Истина;
    ПараметрыВида.МожноИзменятьСпособРедактирования 		= Истина;
    ПараметрыВида.Порядок 									= 20;
    //ПараметрыВида.НастройкиПроверки.ТолькоНациональныйАдрес = Истина;
    //ПараметрыВида.НастройкиПроверки.ПроверятьКорректность 	= Истина;
    //ПараметрыВида.НастройкиПроверки.ПроверятьПоФИАС 		= Истина; // Только для российской версии библиотеки.
    УправлениеКонтактнойИнформацией.УстановитьСвойстваВидаКонтактнойИнформации(ПараметрыВида);
	
    ПараметрыВида = УправлениеКонтактнойИнформацией.ПараметрыВидаКонтактнойИнформации(Перечисления.ТипыКонтактнойИнформации.Телефон);
    ПараметрыВида.Вид 										= Справочники.ВидыКонтактнойИнформации.ТелефонПартнера;
    ПараметрыВида.Используется 								= Истина;
    ПараметрыВида.МожноИзменятьСпособРедактирования 		= Истина;
    ПараметрыВида.Порядок 									= 30;
    //ПараметрыВида.НастройкиПроверки.ТолькоНациональныйАдрес = Истина;
    //ПараметрыВида.НастройкиПроверки.ПроверятьКорректность 	= Истина;
    //ПараметрыВида.НастройкиПроверки.ПроверятьПоФИАС 		= Истина; // Только для российской версии библиотеки.
    УправлениеКонтактнойИнформацией.УстановитьСвойстваВидаКонтактнойИнформации(ПараметрыВида);
	
	
КонецПроцедуры

Процедура ПриДобавленииПодсистемы(Описание) Экспорт
	
	Описание.Имя = "Мюнцкабинет3";
    Описание.Версия = "3.0.0.2";
    // Требуется библиотека стандартных подсистем.
    Описание.ТребуемыеПодсистемы.Добавить("СтандартныеПодсистемы");
	
КонецПроцедуры

Процедура ПриДобавленииОбработчиковОбновления(Обработчики) Экспорт
	
	Обработчик 								= Обработчики.Добавить();
	Обработчик.Версия    					= "*";
	Обработчик.Процедура 					= "ОбновлениеИнформационнойБазыМК.ОбновитьИспользованиеНаборовСвойств";
	Обработчик.РежимВыполнения 				= "Оперативно";
	Обработчик.НачальноеЗаполнение 			= Истина;
	
	Обработчик 								= Обработчики.Добавить();
	Обработчик.Версия    					= "*";
	Обработчик.Процедура 					= "ОбновлениеИнформационнойБазыМК.КонтактнаяИнформацияОбновлениеИБ";
	Обработчик.ВыполнятьВГруппеОбязательных = Истина;
	Обработчик.Приоритет 					= 99;
	
	
КонецПроцедуры

Процедура ПередОбновлениемИнформационнойБазы() Экспорт
	
КонецПроцедуры

Процедура ПослеОбновленияИнформационнойБазы(Знач ПредыдущаяВерсия, Знач ТекущаяВерсия,
        Знач ВыполненныеОбработчики, ВыводитьОписаниеОбновлений, МонопольныйРежим) Экспорт
КонецПроцедуры

Процедура ПриПодготовкеМакетаОписанияОбновлений(Знач Макет) Экспорт
КонецПроцедуры

Процедура ПриДобавленииОбработчиковПереходаСДругойПрограммы(Обработчики) Экспорт
КонецПроцедуры

Процедура ПриОпределенииРежимаОбновленияДанных(РежимОбновленияДанных, СтандартнаяОбработка) Экспорт
КонецПроцедуры 

Процедура ПриЗавершенииПереходаСДругойПрограммы(Знач ПредыдущееИмяКонфигурации, Знач ПредыдущаяВерсияКонфигурации, Параметры) Экспорт
КонецПроцедуры