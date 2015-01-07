#include <a_samp>

public OnGameModeInit()
{
//------ Переменные, которые хранят данные о игроке -------
    new bool:gender = false;
	new bool:hasguitar = true;
	new orgid = 1;
//---------------------------------------------------------
	
//------------ Строки для вывода информации ---------------
	new sgender[8];
	new sorg[32];
	new string[128];
//---------------------------------------------------------
 	
	if(gender) sgender = "Мужской";
	else sgender = "Женский";

    if(orgid == 0)
        sorg = "Отсутствует";
	else if(orgid == 1)
		sorg = "Правительство";
	else if(orgid == 2)
		sorg = "Агентство недвижимости";
	else if(orgid == 3)
		sorg = "Министерство транспорта";

	format(string, 128, "Пол: %s\nОрганизация: %s\n", sgender, sorg);
	print(string);
	
	if(hasguitar && gender)
	    print("Гитарист");
	else if(hasguitar && !gender)
	    print("Гитаристка");

 	/*
 	if(hasguitar)
 	{
 	    if(gender) print("Гитарист");
		else print("Гитаристка");
	}
	*/
	return 1;
}

main()
{

}
