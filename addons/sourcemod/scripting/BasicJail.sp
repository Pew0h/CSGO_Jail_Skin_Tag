/************* Lien utiles **************/ 
// API  : https://sm.alliedmods.net/new-api/
// https://wiki.alliedmods.net/Counter-Strike:_Global_Offensive_Events

// sm plugins reload xx.smx
#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "Pewoh"
#define PLUGIN_VERSION "1.0"

#define GARDIEN_MDL "models/player/custom_player/kuristaja/jailbreak/guard5/guard5.mdl"
#define GARDIEN_ARM_MDL "models/player/custom_player/kuristaja/jailbreak/guard5/guard5_arms.mdl"

#define PRISONNIER_MDL "models/player/custom_player/kuristaja/jailbreak/prisoner1/prisoner1.mdl"
#define PRISONNIER_ARM_MDL "models/player/custom_player/kuristaja/jailbreak/prisoner1/prisoner1_arms.mdl"



#include <sourcemod>
#include <sdktools>
#include <cstrike>
#include <sdkhooks>


#pragma newdecls required

EngineVersion g_Game;

public Plugin myinfo = 
{
	name = "Basic function - Ba_Jail",
	author = PLUGIN_AUTHOR,
	description = "Ajout des fonctions basic style TAG / SKIN / arm models",
	version = PLUGIN_VERSION,
	url = "NULL"
};

public bool IsValidClient(int client)
{
    if(client <= 0)
        return false;
    if(client > MaxClients)
        return false;
    if(!IsClientInGame(client))
        return false;
    if(IsFakeClient(client))
        return false;
    return true;
} 


public void OnPluginStart()
{
	g_Game = GetEngineVersion();
	if(g_Game != Engine_CSGO && g_Game != Engine_CSS)
	{
		SetFailState("Ce plugin est seulement utilisable sur CSS ou CSGO");
	}

	
	HookEvent("player_spawn", Event_Spawn);
	//HookEvent("player_team", Event_Team);
	
}

public void OnMapStart(){

	loadSkinGardien();
	loadSkinPrisonnier();
}



public void Event_Spawn(Event event, const char[] name, bool dontBroadcast) {
	// On récupère le client avec les args de l'event
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	setBasicJail(client);
	
}

public void Event_Team(Event event, const char[] name, bool dontBroadcast) {
	// On récupère le client avec les args de l'event
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	setBasicJail(client);
}

public void setBasicJail(int client){
	
	if(GetClientTeam(client) == CS_TEAM_CT){
		CS_SetClientClanTag(client, "[Gardien]");
		
		SetEntityModel(client, GARDIEN_MDL);
		SetEntPropString(client, Prop_Send, "m_szArmsModel", GARDIEN_ARM_MDL);
	}
	
	else if(GetClientTeam(client) == CS_TEAM_T){
		CS_SetClientClanTag(client, "[Prisonnier]");
		
		SetEntityModel(client, PRISONNIER_MDL);
		SetEntPropString(client, Prop_Send, "m_szArmsModel", PRISONNIER_ARM_MDL);
	}
	
	else if(GetClientTeam(client) == CS_TEAM_SPECTATOR){
		CS_SetClientClanTag(client, "[Spectateur]");
	}
}

public void loadSkinGardien(){
	
	// Partie Models
	AddFileToDownloadsTable("models/player/custom_player/kuristaja/jailbreak/guard5/guard5.dx90.vtx");
	AddFileToDownloadsTable("models/player/custom_player/kuristaja/jailbreak/guard5/guard5.mdl");
	AddFileToDownloadsTable("models/player/custom_player/kuristaja/jailbreak/guard5/guard5.phy");
	AddFileToDownloadsTable("models/player/custom_player/kuristaja/jailbreak/guard5/guard5.vvd");
	
	AddFileToDownloadsTable("models/player/custom_player/kuristaja/jailbreak/guard5/guard5_arms.dx90.vtx");
	AddFileToDownloadsTable("models/player/custom_player/kuristaja/jailbreak/guard5/guard5_arms.mdl");
	AddFileToDownloadsTable("models/player/custom_player/kuristaja/jailbreak/guard5/guard5_arms.vvd");
	
	//Partie material
	AddFileToDownloadsTable("materials/models/player/kuristaja/jailbreak/guard5/guard_head_a6_d.vmt");
	AddFileToDownloadsTable("materials/models/player/kuristaja/jailbreak/guard5/guard_hs_body_d.vmt");
	AddFileToDownloadsTable("materials/models/player/kuristaja/jailbreak/guard5/guard_hs_head_d.vmt");
	AddFileToDownloadsTable("materials/models/player/kuristaja/jailbreak/guard5/guard_head_a6_d.vtf");
	AddFileToDownloadsTable("materials/models/player/kuristaja/jailbreak/guard5/guard_head_a6_normal.vtf");
	AddFileToDownloadsTable("materials/models/player/kuristaja/jailbreak/guard5/guard_hs_body_d.vtf");
	AddFileToDownloadsTable("materials/models/player/kuristaja/jailbreak/guard5/guard_hs_body_normal.vtf");
	AddFileToDownloadsTable("materials/models/player/kuristaja/jailbreak/guard5/guard_hs_head_d.vtf");
	AddFileToDownloadsTable("materials/models/player/kuristaja/jailbreak/guard5/guard_hs_head_normal.vtf");
	
	//Precache models
	PrecacheModel(GARDIEN_MDL, true);
	PrecacheModel(GARDIEN_ARM_MDL, true);
	
}

public void loadSkinPrisonnier(){
	
	/////////// MODELS PART ////////////
	
	AddFileToDownloadsTable("models/player/custom_player/kuristaja/jailbreak/prisoner1/prisoner1.dx90.vtx");
	AddFileToDownloadsTable("models/player/custom_player/kuristaja/jailbreak/prisoner1/prisoner1.mdl");
	AddFileToDownloadsTable("models/player/custom_player/kuristaja/jailbreak/prisoner1/prisoner1.phy");
	AddFileToDownloadsTable("models/player/custom_player/kuristaja/jailbreak/prisoner1/prisoner1.vvd");
	
	/* arms */
	AddFileToDownloadsTable("models/player/custom_player/kuristaja/jailbreak/prisoner1/prisoner1_arms.dx90.vtx");
	AddFileToDownloadsTable("models/player/custom_player/kuristaja/jailbreak/prisoner1/prisoner1_arms.mdl");
	AddFileToDownloadsTable("models/player/custom_player/kuristaja/jailbreak/prisoner1/prisoner1_arms.vvd");
	
	////////////MATERIAL PART//////////
	
	/* vmt part */
	AddFileToDownloadsTable("materials/models/player/kuristaja/jailbreak/prisoner1/eye_d.vmt");
	AddFileToDownloadsTable("materials/models/player/kuristaja/jailbreak/prisoner1/prisoner_lt_bottom_d.vmt");
	AddFileToDownloadsTable("materials/models/player/kuristaja/jailbreak/prisoner1/prisoner_lt_head_d.vmt");
	AddFileToDownloadsTable("materials/models/player/kuristaja/jailbreak/prisoner1/prisoner_lt_top_d.vmt");
	AddFileToDownloadsTable("materials/models/player/kuristaja/jailbreak/prisoner1/prisoners_torso_d.vmt");
	
	/* vtf part*/
	AddFileToDownloadsTable("materials/models/player/kuristaja/jailbreak/prisoner1/eye_d.vtf");
	AddFileToDownloadsTable("materials/models/player/kuristaja/jailbreak/prisoner1/prisoner_lt_bottom_d.vtf");
	AddFileToDownloadsTable("materials/models/player/kuristaja/jailbreak/prisoner1/prisoner_lt_bottom_normal.vtf");
	AddFileToDownloadsTable("materials/models/player/kuristaja/jailbreak/prisoner1/prisoner_lt_head_d.vtf");
	AddFileToDownloadsTable("materials/models/player/kuristaja/jailbreak/prisoner1/prisoner_lt_head_normal.vtf");
	AddFileToDownloadsTable("materials/models/player/kuristaja/jailbreak/prisoner1/prisoner_lt_top_d.vtf");
	AddFileToDownloadsTable("materials/models/player/kuristaja/jailbreak/prisoner1/prisoner_lt_top_normal.vtf");
	AddFileToDownloadsTable("materials/models/player/kuristaja/jailbreak/prisoner1/prisoners_torso_d.vtf");
	
	//Precache models
	PrecacheModel(PRISONNIER_MDL, true);
	PrecacheModel(PRISONNIER_ARM_MDL, true);
	
}
