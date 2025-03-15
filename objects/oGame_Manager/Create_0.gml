#region Player

global.Player_HpMax = 6;
global.Player_Hp = global.Player_HpMax;
global.Player_LivesMax = 99;
global.Player_Lives = 2;
global.Player_Coins = 0;
global.Player_Power = 0;

#endregion

#region Room state
global.Room_SpecialBox_inRoom = instance_number(oSpecialBox);
global.Room_SpecialBox_Broken = 0;
global.Room_SpecialBox_Completed = false;
global.Room_MapPieces = [false,false,false,false];
global.has_full_map = false;

#endregion

#region Checkpoint

global.savedState = {}; // Estado del checkpoint actual
global.currentState = {}; // Estado temporal de la partida en la room
global.checkpointActive = noone; // Instancia del checkpoint activo

// Posición inicial del jugador
global.respawnX = oPlayer.x;
global.respawnY = oPlayer.y;

// Estado de los objetos
global.currentState = ds_list_create();  // Ítems recogidos en la vida actual
global.savedState = ds_list_create();    // Ítems guardados en un checkpoint

// Último checkpoint activado
global.checkpointActive = noone;

#endregion

#region pause

pauseButton=false;
global.paused = false;

#endregion