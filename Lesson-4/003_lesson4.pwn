#include <a_samp>

public OnGameModeInit()
{
	const PLAYERS = 3;
//--------- Массивы для хранения данных о игроках ---------
	new bool:Gender[PLAYERS];
	new OrgID[PLAYERS];
//---------------------------------------------------------
	Gender[0] = true;
	Gender[1] = false;
	Gender[2] = true;

	OrgID[0] = 1;
	OrgID[1] = 0;
	OrgID[2] = 2;
//---------------------------------------------------------
	for(new i = 0; i < PLAYERS; i++)
	{
	    new sgender[8], sorg[32];

	    if(Gender[i]) sgender = "Мужской";
	    else sgender = "Женский";

	    if(OrgID[i] == 0)
	        sorg = "Отсутствует";
		else if(OrgID[i] == 1)
		    sorg = "Правительство";
		else sorg = "Агентство недвижимости";

		printf("Пол: %s | Организация: %s", sgender, sorg);
	}
	return 1;
}

main()
{

}
