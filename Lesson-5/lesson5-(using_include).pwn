#include <a_samp>
#include <core>
#include <float>

#include <CreateEntrance>

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

 	//CreateEntrance(etext[], emodelid, Float:x, Float:y, Float:z, Float:a, Float:tox, Float:toy, Float:toz, Float:toa, worldid = 0, intid = -1)
	CreateEntrance("Вход в дом", 1239, -2173.7473,-2481.5774,31.8163,318.4962, 243.7234,305.0653,999.1484, 272.8875, 0, 1);
	CreateEntrance("Тест (Вход)", 1239, 1962.9926,1344.1982,15.4823,266.6959, -2181.5020,-2479.0840,30.6172,316.6663, 0);

	CreateEntrance("Вход в дом", 1239, -2199.7434,-2512.4966,31.8163,138.5179, 243.7234,305.0653,999.1484, 272.8875, 1, 1);
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_WALK)
	{
		new enterID = GetPlayerEntranceID(playerid);
		if(enterID != -1)
		{
			TeleportPlayerToExit(playerid, enterID);
			return 1;
		}

		new exitID = GetPlayerExitID(playerid);
		if(exitID != -1)
		{
			TeleportPlayerToEntrance(playerid, exitID);
			return 1;
		}
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

	if(strcmp(cmd, "/tp2", true) == 0) {
		TeleportPlayerToEntrance(playerid, 0);
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
