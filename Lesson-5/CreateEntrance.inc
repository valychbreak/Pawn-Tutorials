#tryinclude <a_samp>
#tryinclude <streamer>

#if !defined MAX_ENTRANCES
	#define MAX_ENTRANCES 100
#endif

enum E_EnterExitInfo
{
	eeModelID,
	Float:eeEnterPos[4],
	Float:eeExitPos[4],

	eeEnterWorldID,
	eeEnterIntID,

	eeExitWorldID,
	eeExitIntID,

	Text3D:eeEnterTextID,
	eeEnterPickupID,

	Text3D:eeExitTextID,
	eeExitPickupID
}
new v_EntranceInfo[MAX_ENTRANCES][E_EnterExitInfo];

/*
	CreateEntrance - создает вход и выход на указанных координатах (создает пикап + 3д текст)

	Параметры:
	etext[]			Текст, который будет над пикапом ВХОДА 
	eeModelID 		Модель пикапа (id объекта)
	Float:x 		Позиция входа по Х
	Float:y 		Позиция входа по Y
	Float:z 		Позиция входа по Z
	Float:a 		Поворот игрока, который установится после перемещения на ВХОД
	Float:tox 		Позиция выхода по Х
	Float:toy		Позиция выхода по Y
	Float:toz 		Позиция выхода по Z
	Float:toa 		Поворот игрока, который установится после перемещения на ВЫХОД
	worldid 		Виртуальный мир, в котором находится ВЫХОД (по умолчанию -1)
	intid 			Интерьер, в котором находится ВЫХОД (по умолчанию -1)

	Возвращает ID входа или -1, если вход не создан (превышен лимит входов).
*/
stock CreateEntrance(etext[], emodelid, Float:x, Float:y, Float:z, Float:a, Float:tox, Float:toy, Float:toz, Float:toa, worldid = -1, intid = -1)
{
	new id = -1;
	for(new i = 0; i < MAX_ENTRANCES; i++)
	{
		if(v_EntranceInfo[i][eeModelID] == 0)
		{
			id = i;
			break;
		}
	}
	if(id == -1) { printf("> Entrance error: превышен лимит входов."); return -1; }

	v_EntranceInfo[id][eeModelID] = emodelid;
	v_EntranceInfo[id][eeEnterPos][0] = x;
	v_EntranceInfo[id][eeEnterPos][1] = y;
	v_EntranceInfo[id][eeEnterPos][2] = z;
	v_EntranceInfo[id][eeEnterPos][3] = a;

	v_EntranceInfo[id][eeExitPos][0] = tox;
	v_EntranceInfo[id][eeExitPos][1] = toy;
	v_EntranceInfo[id][eeExitPos][2] = toz;
	v_EntranceInfo[id][eeExitPos][3] = toa;

	v_EntranceInfo[id][eeEnterWorldID] = 0;
	v_EntranceInfo[id][eeEnterIntID] = -1;

	v_EntranceInfo[id][eeExitWorldID] = worldid;
	v_EntranceInfo[id][eeExitIntID] = intid;

	#if defined CreateDynamicPickup
		/* Streamer version: */

		// v_EntranceInfo[id][eeEnterWorldID] = -1;
		// v_EntranceInfo[id][eeEnterIntID] = -1;

		v_EntranceInfo[id][eeEnterPickupID] = CreateDynamicPickup(emodelid, 1, x, y, z, v_EntranceInfo[id][eeEnterWorldID]);
		v_EntranceInfo[id][eeEnterTextID] = CreateDynamic3DTextLabel(etext, 0xC4BE02FF,x+0.03,y+0.05,z + 0.8, 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, v_EntranceInfo[id][eeEnterWorldID]);

		v_EntranceInfo[id][eeExitPickupID] = CreateDynamicPickup(emodelid, 1, tox, toy, toz, worldid);
		v_EntranceInfo[id][eeExitTextID] = CreateDynamic3DTextLabel("Выход", 0xC4BE02FF, tox+0.03, toy+0.05, toz + 0.8, 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, worldid);
	#else
		if(worldid == -1) v_EntranceInfo[id][eeExitWorldID] = 0;
		//v_EntranceInfo[id][eeEnterIntID] = -1;

		v_EntranceInfo[id][eeEnterPickupID] = CreatePickup(emodelid, 1, x, y, z, v_EntranceInfo[id][eeEnterWorldID]);
		v_EntranceInfo[id][eeEnterTextID] = Create3DTextLabel(etext, 0xC4BE02FF,x+0.03,y+0.05,z + 0.8, 30.0, v_EntranceInfo[id][eeEnterWorldID], 1);

		v_EntranceInfo[id][eeExitPickupID] = CreatePickup(emodelid, 1, tox, toy, toz, v_EntranceInfo[id][eeExitWorldID]);
		v_EntranceInfo[id][eeExitTextID] = Create3DTextLabel("Выход", 0xC4BE02FF, tox+0.03, toy+0.05, toz + 0.8, 30.0, v_EntranceInfo[id][eeExitWorldID], 1);
	#endif

	return id;
}
/*
	DestroyEntrance - удаляет указанный вход с выходом

	Параметры:
	id - Порядковый ID входа

	Возвращает 0, если вход не создан. Возвращает 1 при удачном удалении
*/
stock DestroyEntrance(id)
{
	if(id < 0 || id > MAX_ENTRANCES - 1) return 0;

	DestroyDynamicPickup(v_EntranceInfo[id][eeEnterPickupID]);
	DestroyDynamic3DTextLabel(v_EntranceInfo[id][eeEnterTextID]);
	DestroyDynamicPickup(v_EntranceInfo[id][eeExitPickupID]);
	DestroyDynamic3DTextLabel(v_EntranceInfo[id][eeExitTextID]);

	v_EntranceInfo[id][eeModelID] = 0;
	for(new i = 0; i < 4; i++)
	{
		v_EntranceInfo[id][eeEnterPos][i] = 0;
		v_EntranceInfo[id][eeExitPos][i] = 0;
	}
	return 1;
}
/*
	TeleportPlayerToEntrance - телепортирует игрока на указанный ВХОД

	Параметры:
	playerid 	ID игрока,  которого нужно телепортировать
	id 			ID входа (возвращается функцией CreateEntrance)
*/
stock TeleportPlayerToEntrance(playerid, id)
{
	if(id < 0 || id > MAX_ENTRANCES - 1) return 0;
	if(v_EntranceInfo[id][eeModelID] == 0) return 0;

	SetPlayerPos(playerid, v_EntranceInfo[id][eeEnterPos][0], v_EntranceInfo[id][eeEnterPos][1], v_EntranceInfo[id][eeEnterPos][2]);
	SetPlayerFacingAngle(playerid, v_EntranceInfo[id][eeEnterPos][3]);

	if(v_EntranceInfo[id][eeEnterWorldID] == -1) SetPlayerVirtualWorld(playerid, 0);
	else SetPlayerVirtualWorld(playerid, v_EntranceInfo[id][eeEnterWorldID]);

	if(v_EntranceInfo[id][eeEnterIntID] == -1) SetPlayerInterior(playerid, 0);
	else SetPlayerInterior(playerid, v_EntranceInfo[id][eeEnterIntID]);
	return 1;
}
/*
	TeleportPlayerToExit - телепортирует игрока на указанный ВЫХОД

	Параметры:
	playerid 	ID игрока,  которого нужно телепортировать
	id 			ID входа (возвращается функцией CreateEntrance)
*/
stock TeleportPlayerToExit(playerid, id)
{
	if(id < 0 || id > MAX_ENTRANCES - 1) return 0;
	if(v_EntranceInfo[id][eeModelID] == 0) return 0;

	SetPlayerPos(playerid, v_EntranceInfo[id][eeExitPos][0], v_EntranceInfo[id][eeExitPos][1], v_EntranceInfo[id][eeExitPos][2]);
	SetPlayerFacingAngle(playerid, v_EntranceInfo[id][eeExitPos][3]);

	if(v_EntranceInfo[id][eeExitWorldID] == -1) SetPlayerVirtualWorld(playerid, 0);
	else SetPlayerVirtualWorld(playerid, v_EntranceInfo[id][eeExitWorldID]);

	if(v_EntranceInfo[id][eeExitIntID] == -1) SetPlayerInterior(playerid, 0);
	else SetPlayerInterior(playerid, v_EntranceInfo[id][eeExitIntID]);
	return 1;
}

/*
	GetPlayerEntranceID - возвращает ID входа, на ВХОДЕ которого стоит игрок

	Параметры:
	playerid - ID игрока
*/
stock GetPlayerEntranceID(playerid)
{
	for(new id = 0; id < MAX_ENTRANCES; id++)
	{
		if(v_EntranceInfo[id][eeModelID] != 0 && IsPlayerInRangeOfPoint(playerid, 1.5, v_EntranceInfo[id][eeEnterPos][0],v_EntranceInfo[id][eeEnterPos][1],v_EntranceInfo[id][eeEnterPos][2]))
		{
			/*if(v_EntranceInfo[id][eeEnterWorldID] == -1 && v_EntranceInfo[id][eeEnterIntID] == -1)
				return id;
			else if(v_EntranceInfo[id][eeEnterIntID] != -1 && GetPlayerInterior(playerid) == v_EntranceInfo[id][eeEnterIntID])
				return id;
			else if(v_EntranceInfo[id][eeEnterWorldID] != -1 && GetPlayerVirtualWorld(playerid) == v_EntranceInfo[id][eeEnterWorldID])
				return id;*/
			return id;
		}
	}
	return -1;
}

/*
	GetPlayerExitID - возвращает ID ВХОДА, на ВЫХОДЕ которого стоит игрок

	Параметры:
	playerid - ID игрока
*/
stock GetPlayerExitID(playerid)
{
	for(new id = 0; id < MAX_ENTRANCES; id++)
	{
		if(v_EntranceInfo[id][eeModelID] != 0 && IsPlayerInRangeOfPoint(playerid, 1.5, v_EntranceInfo[id][eeExitPos][0],v_EntranceInfo[id][eeExitPos][1],v_EntranceInfo[id][eeExitPos][2]))
		{
			if(v_EntranceInfo[id][eeExitWorldID] == -1 && v_EntranceInfo[id][eeExitIntID] == -1)
				return id;
			else if(v_EntranceInfo[id][eeExitIntID] != -1 && v_EntranceInfo[id][eeExitWorldID] == -1 && GetPlayerInterior(playerid) == v_EntranceInfo[id][eeExitIntID])
				return id;
			else if(v_EntranceInfo[id][eeExitIntID] == -1 && v_EntranceInfo[id][eeExitWorldID] != -1 && GetPlayerVirtualWorld(playerid) == v_EntranceInfo[id][eeExitWorldID])
				return id;
			else if(GetPlayerInterior(playerid) == v_EntranceInfo[id][eeExitIntID] && GetPlayerVirtualWorld(playerid) == v_EntranceInfo[id][eeExitWorldID])
				return id;
		}
	}
	return -1;
}
