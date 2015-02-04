#include <a_samp>
#include <core>
#include <float>

#pragma tabsize 0

main()
{
	print("\n----------------------------------");
	print("  Bare Script\n");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
	SetGameModeText("Bare Script");
	ShowPlayerMarkers(1);
	ShowNameTags(1);
	AllowAdminTeleport(1);
	AddPlayerClass(265,1958.3783,1343.1572,15.3746,270.1425,0,0,0,0,-1,-1);

//------------ Дом 1 ------------------
	CreatePickup(1239, 1, -2173.7473,-2481.5774,31.8163); // вход
	Create3DTextLabel("House 1", 0xC4BE02FF, -2173.7473,-2481.5774,31.8163, 40.0, 0, 0);

	CreatePickup(1239, 1, 243.7234,305.0653,999.1484); // выход
	Create3DTextLabel("Exit", 0xC4BE02FF, 243.7234,305.0653,999.1484, 40.0, 0, 0);
//------------- Тест -------------------
	CreatePickup(1239, 1, 1962.9926,1344.1982,15.4823); // вход
	Create3DTextLabel("Test (Entrance)", 0xC4BE02FF, 1962.9926,1344.1982,15.4823, 40.0, 0, 0);

	CreatePickup(1239, 1, -2181.5020,-2479.0840,30.6172); // выход
	Create3DTextLabel("Test (Exit)", 0xC4BE02FF, -2181.5020,-2479.0840,30.6172, 40.0, 0, 0);
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_WALK)
	{
	//-------------- Дом1 Вход + Выход -------------
		if(IsPlayerInRangeOfPoint(playerid, 1.5, -2173.7473,-2481.5774,31.8163)) // если находится на входе
		{
			SetPlayerPos(playerid, 243.7234,305.0653,999.1484); // ТП игрока на позицию выхода
			SetPlayerFacingAngle(playerid, 272.8875);
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, 0);
		}
		else if(IsPlayerInRangeOfPoint(playerid, 1.5, 243.7234,305.0653,999.1484)) // если находится на выходе
		{
			SetPlayerPos(playerid, -2173.7473,-2481.5774,31.8163); // ТП игрока на позицию входа
			SetPlayerFacingAngle(playerid, 318.4962);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
		}
	//----------- Тест 1 Вход + Выход -------------
		else if(IsPlayerInRangeOfPoint(playerid, 1.5, 1962.9926,1344.1982,15.4823))
		{
			SetPlayerPos(playerid, -2181.5020,-2479.0840,30.6172);
			SetPlayerFacingAngle(playerid, 316.6663);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
		}
		else if(IsPlayerInRangeOfPoint(playerid, 1.5, -2181.5020,-2479.0840,30.6172))
		{
			SetPlayerPos(playerid, 1962.9926,1344.1982,15.4823);
			SetPlayerFacingAngle(playerid, 266.6959);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
		}
	// ----------------------------------------------
	}
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
	new idx;
	new cmd[256];
	
	cmd = strtok(cmdtext, idx);

	if(strcmp(cmd, "/tp", true) == 0) {
		SetPlayerPos(playerid, -2182.7505,-2494.3513,30.4688);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
    	return 1;
	}

	return 0;
}


public OnPlayerConnect(playerid)
{
	GameTextForPlayer(playerid,"~w~SA-MP: ~r~Bare Script",5000,5);
	return 1;
}


public OnPlayerSpawn(playerid)
{
	SetPlayerInterior(playerid,0);
	TogglePlayerClock(playerid,0);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
   	return 1;
}

SetupPlayerForClassSelection(playerid)
{
 	SetPlayerInterior(playerid,14);
	SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
	SetPlayerFacingAngle(playerid, 270.0);
	SetPlayerCameraPos(playerid,256.0815,-43.0475,1004.0234);
	SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
}

public OnPlayerRequestClass(playerid, classid)
{
	SetupPlayerForClassSelection(playerid);
	return 1;
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
