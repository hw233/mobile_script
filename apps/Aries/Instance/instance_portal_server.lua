--[[
Title: Server agent template class
Author(s): 
Date: 2010/11/2
Desc: Project Aries app_main
use the lib:
------------------------------------------------------------
NPL.load("(gl)script/apps/Aries/Combat/Instance/instance_portal_server.lua");
------------------------------------------------------------
]]
--NPL.load("(gl)script/apps/GameServer/GSL_config.lua");
--
--local format = format;
--local tonumber, tostring = tonumber, tostring;
--local math_random = math.random;
--local math_floor = math.floor;
--local LOG = LOG;
---- create class
--local Combat_Server = commonlib.gettable("MyCompany.Aries.Combat_Server");
--
---------------------------------------
---- a special server NPC that just echos whatever received. 
---------------------------------------
---- keep a reference of the combat_server
--local combat_server = commonlib.gettable("MyCompany.Aries.Combat_Server.combat_server");
--
---- register NPC template
--Map3DSystem.GSL.config:RegisterNPCTemplate("aries_combat_system", combat_server);
--
---- essential combat includes
--NPL.load("(gl)script/apps/Aries/Combat/ServerObject/mob_server.lua");
--NPL.load("(gl)script/apps/Aries/Combat/ServerObject/player_server.lua");
--NPL.load("(gl)script/apps/Aries/Combat/ServerObject/ai_module_server.lua");
--NPL.load("(gl)script/apps/Aries/Combat/ServerObject/card_server.lua");
--NPL.load("(gl)script/apps/Aries/Combat/ServerObject/arena_server.lua");
--NPL.load("(gl)script/apps/Aries/Combat/ServerObject/msg_handler_server.lua");
--
--local Mob = commonlib.gettable("MyCompany.Aries.Combat_Server.Mob");
--local Player = commonlib.gettable("MyCompany.Aries.Combat_Server.Player");
--local AI_Module = commonlib.gettable("MyCompany.Aries.Combat_Server.AI_Module");
--local Card = commonlib.gettable("MyCompany.Aries.Combat_Server.Card");
--local Arena = commonlib.gettable("MyCompany.Aries.Combat_Server.Arena");
--local Msg_Handler_server = commonlib.gettable("MyCompany.Aries.Combat_Server.Msg_Handler_server");
--local GSL_gateway = commonlib.gettable("Map3DSystem.GSL.gateway");
--local table_insert = table.insert;
--
--local isInitCard = false;
--
---- pending normal update messages
--local pending_messages_normal_update = {};
---- pending real time messages
--local pending_messages_realtime_update = {};
---- pending real time messages to user nid
--local pending_messages_realtime_update_to_nid = {};
--
--function combat_server.CreateInstance(self, revision)
	---- overwrite virtual functions
	--self.OnNetReceive = combat_server.OnNetReceive;
	--self.OnFrameMove = combat_server.OnFrameMove;
	---- uncomment to overwrite default AddRealtimeMessage implementation, such as adding a message compression layer.
	---- self.AddRealtimeMessage = combat_server.AddRealtimeMessage;
	--
	---- init card related data
	--if(not isInitCard) then
		---- init card key and gsid mapping
		--Card.InitCardKey_gsid_mapping();
		---- init card data from file
		--Card.InitCardDataFromFile("config/Aries/Cards/CardList.xml");
		---- init charm and ward data from file
		--Card.InitCharmAndWardDataFromFile("config/Aries/Cards/CharmWardList.xml");
		--isInitCard = true;
	--end
--
	---- read serverobject npc data
	--local arenas_mobs_config;
	--local arenas_mobs;
	--for arenas_mobs in commonlib.XPath.eachNode(self.npc_node, "/arenas_mobs") do
		--arenas_mobs_config = arenas_mobs.attr.config;
	--end
	--
	---- set the world config file, the config file works as key to each queue
	--self.world_config_file = arenas_mobs_config;
	---- load arena and mob from config file
	--Arena.InitArenaAndMobFromFile(arenas_mobs_config);
--end
---- appending normal update message
--function combat_server.AppendNormalUpdateMessage(world_config_file, key, value)
	--if(not pending_messages_normal_update[world_config_file]) then
		--pending_messages_normal_update[world_config_file] = {};
	--end
	--table_insert(pending_messages_normal_update[world_config_file], {key = key, value = value});
--end
--
---- appending real time message
---- NOTE: a combat prefix is automatically added: [Aries][combat_to_client]
--function combat_server.AppendRealTimeMessage(world_config_file, msg)
	--LOG.std(nil, "user","combat_server","AppendRealTimeMessage:%s",commonlib.serialize_compact(msg));
	--if(not pending_messages_realtime_update[world_config_file]) then
		--pending_messages_realtime_update[world_config_file] = {};
	--end
	----commonlib.applog("combat_server.AppendRealTimeMessage");
	----log(msg.."\n");
	--table_insert(pending_messages_realtime_update[world_config_file], "[Aries][combat_to_client]"..msg);
--end
--
---- appending real time message to user nid
---- NOTE: a combat prefix is automatically added: [Aries][combat_to_client]
--function combat_server.AppendRealTimeMessageToNID(world_config_file, nid, msg)
	--LOG.std(nil, "user","combat_server","AppendRealTimeMessageToNID:%d,%s",nid,commonlib.serialize_compact(msg));
	--if(not pending_messages_realtime_update_to_nid[world_config_file]) then
		--pending_messages_realtime_update_to_nid[world_config_file] = {};
	--end
	----commonlib.applog("combat_server.AppendRealTimeMessageToNID %d", nid);
	----log(msg.."\n");
	--table_insert(pending_messages_realtime_update_to_nid[world_config_file], {nid = nid, msg = "[Aries][combat_to_client]"..msg});
--end
--
---- try send pending message and normal update
---- @param revision: normal update revision
--function combat_server.TrySendPendingAllMessages(server_obj, revision)
	--if(not server_obj) then
		--LOG.std(nil, "error", "combat_server", "error: nil server object got in combat_server.TrySendPendingAll");
		--return;
	--end
	---- world config file
	--local world_config_file = server_obj.world_config_file;
	---- check normal update messages
	--local _, o;
	--for _, o in ipairs(pending_messages_normal_update[world_config_file] or {}) do
		--server_obj:SetValue(o.key, o.value, revision);
	--end
	---- clear normal update messages
	--pending_messages_normal_update[world_config_file] = {};
	---- check real time messages
	--local _, msg;
	--for _, msg in ipairs(pending_messages_realtime_update[world_config_file] or {}) do
		--server_obj:AddRealtimeMessage(msg);
	--end
	---- clear normal update messages
	--pending_messages_realtime_update[world_config_file] = {};
	---- check real time messages to nid
	--local _, o;
	--for _, o in ipairs(pending_messages_realtime_update_to_nid[world_config_file] or {}) do
		--server_obj:SendRealtimeMessage(tostring(o.nid), o.msg);
	--end
	---- clear normal update messages
	--pending_messages_realtime_update_to_nid[world_config_file] = {};
--end
--
---- whenever an instance of this server agent has received a real time message from client (from_nid) in gridnode, this function will be called.  
--function combat_server:OnNetReceive(from_nid, gridnode, msg, revision)
	--
	---- set current time
	--current_time = ParaGlobal.timeGetTime();
--
	--if(from_nid and gridnode) then
		--LOG.std(nil, "user","combat_server","nid=%s|NetReceive:%s",from_nid,msg.body);
		--Msg_Handler_server.MsgProc(from_nid, msg.body);		
	--end
--
	---- additional framemove for nid
	--from_nid = tonumber(from_nid);
	--
	---- on frame move arena objects
	--Arena.OnFrameMove_for_nid(from_nid, combat_server.GetCurrentTime());
	--
	---- try sending all pending messages
	--combat_server.TrySendPendingAllMessages(self, revision);
	--
	------ echo real time message to client
	----self:AddRealtimeMessage(msg)
--end
--
---- current game server time
--local current_time = 0;
--function combat_server.GetCurrentTime()
	--return current_time;
--end
--
---- This function is called by gridnode at normal update interval. One can update persistent data fields in this functions. 
--function combat_server:OnFrameMove(curTime, revision)
	---- current time in milli-seconds
	---- cast the current time to integar
	--curTime = math.floor(curTime);
	---- set current time
	--current_time = curTime;
	--
	---- on frame move arena objects
	--Arena.OnFrameMove_all(curTime);
	--
	---- combat_server.AppendRealTimeMessage("heartbeat:"..curTime)
	--
	---- try sending all pending messages
	--combat_server.TrySendPendingAllMessages(self, revision);
--end