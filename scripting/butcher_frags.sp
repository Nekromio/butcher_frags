#pragma semicolon 1
#pragma newdecls required

#include <butcher_core>

ConVar
	cvBonusFrags;

public Plugin myinfo =
{
	name = "[Butcher Core] Frags bonus",
	author = "Nek.'a 2x2 | ggwp.site ",
	description = "Дополнительные фраги Мяснику",
	version = "1.0.0",
	url = "https://ggwp.site/"
};

public void OnPluginStart()
{
	cvBonusFrags = CreateConVar("sm_butcher_bonus_frags", "1", "Сколько дополнительных фрагов получит Мясник?");

	AutoExecConfig(true, "frags", "butcher");
}

public void BUTCHER_PlayerDeath(int client, int attacker)
{
	if(IsValidClient(attacker) && !IsFakeClient(attacker) && BUTCHER_GetStstusButcher(attacker))
	{
		if(IsValidClient(client) && attacker == client)
		{
			return;
		}
		SetEntProp(attacker, Prop_Data, "m_iFrags", GetClientFrags(attacker) + cvBonusFrags.IntValue);
	}
}

stock bool IsValidClient(int client)
{
	return 0 < client <= MaxClients && IsClientInGame(client);
}