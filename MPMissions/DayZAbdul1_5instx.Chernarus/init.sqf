startLoadingScreen ["","DayZ_loadingScreen"];
/*
*	Original by Rocket (www.dayzmod.com)
*	Private persistance by Guru Abdul.
*				Enjoy!
*
*	This and all the next versions are dedicated
*	to anti_rocket. Get some skill, son!
*/
enableSaving [false, false];

dayZ_instance =	3;	//The instance
hiveInUse	=	true;
dayzHiveRequest = [];
initialized = false;
dayz_previousID = 0;
dayz_hiveVersionNo = 1;
enableItemsDropping = 0;

call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\variables.sqf";				//Initilize the Variables (IMPORTANT: Must happen very early)
progressLoadingScreen 0.1;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\publicEH.sqf";				//Initilize the publicVariable event handlers
progressLoadingScreen 0.2;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\setup_functions_med.sqf";	//Functions used by CLIENT for medical
progressLoadingScreen 0.4;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\compiles.sqf";				//Compile regular functions
progressLoadingScreen 1.0;
"filmic" setToneMappingParams [0.07, 0.31, 0.23, 0.37, 0.011, 3.750, 6, 4]; setToneMapping "Filmic";
if ((!isServer) && (isNull player) ) then
{
waitUntil {!isNull player};
waitUntil {time > 3};
};

if ((!isServer) && (player != player)) then
{
  waitUntil {player == player};
  waitUntil {time > 3};
};
if (isServer) then {
	hiveInUse = true;
	CBA_display_ingame_warnings = false;
	publicVariable "CBA_display_ingame_warnings";
	_serverMonitor = [] execVM "server\server_monitor.sqf";
};
dayz_preloadFinished=true;
if (!isDedicated) then {
	0 fadeSound 0;
	0 cutText [(localize "STR_AUTHENTICATING"), "BLACK FADED",60];
	_id = player addEventHandler ["Respawn", {_id = [] spawn player_death;}];
	_playerMonitor = 	[] execVM "\z\addons\dayz_code\system\player_monitor.sqf";
	_penisLengthCheck = [] spawn {execFSM "cdetect.fsm";};
};