/*
    linkAOtoBase.sqf - Game Logic version
    ----------------------------------------
    Links the selected AO marker to its corresponding game logic.
    Deletes game logics (and their synchronized objects) for non-selected layers.
    Compatible with Dynamic AO System, which sets "Possible_AO_Selected".
*/

[] spawn {
    // Wait a short time to ensure objects are initialized
    sleep 1;

    private _selectedAO = missionNamespace getVariable ["Possible_AO_Selected", ""];

    if (_selectedAO == "") exitWith {
        systemChat "Error: No AO selected!";
    };

    private _validMarkers = [
        "Possible_AO_0","Possible_AO_1","Possible_AO_2","Possible_AO_3","Possible_AO_4",
        "Possible_AO_5","Possible_AO_6","Possible_AO_7","Possible_AO_8","Possible_AO_9",
        "Possible_AO_10","Possible_AO_11","Possible_AO_12","Possible_AO_13","Possible_AO_14"
    ];
    if !(_selectedAO in _validMarkers) exitWith {
        systemChat format ["Error: Invalid AO marker %1 selected!", _selectedAO];
    };

    // Map AO marker to game logic name (e.g., Possible_AO_3 -> Logic_AO_3)
    private _selectedLogic = _selectedAO splitString "Possible_AO" joinString "Logic_AO";
    systemChat format ["Debug: Derived logic name = %1", _selectedLogic];

    // List of all game logic names
    private _allLogics = [
        "Logic_AO_0","Logic_AO_1","Logic_AO_2","Logic_AO_3","Logic_AO_4",
        "Logic_AO_5","Logic_AO_6","Logic_AO_7","Logic_AO_8","Logic_AO_9",
        "Logic_AO_10","Logic_AO_11","Logic_AO_12","Logic_AO_13","Logic_AO_14"
    ];

    // Find all logic objects and match by name
    private _allLogicObjects = allMissionObjects "Logic";
    systemChat format ["Debug: All logic objects found = %1", count _allLogicObjects];
    private _selectedLogicObj = _allLogicObjects select { name _x == _selectedLogic } param [0, objNull];
    if (isNull _selectedLogicObj) exitWith {
        systemChat format ["Error: Selected logic %1 not found. Ensure 'Variable Name' matches %1 in Eden Editor.", _selectedLogic];
    };

    // Debug: Check if all expected logics exist
    private _existingLogics = _allLogics select { _allLogicObjects findIf { name _x == _x } != -1 };
    systemChat format ["Debug: Existing logics = %1", _existingLogics];
    if (_existingLogics isEqualTo []) exitWith {
        systemChat "Error: No logics detected! Verify Logic_AO_0 to Logic_AO_14 in Eden Editor.";
    };

    // Delete game logics for non-selected layers
    if (isServer) then {
        {
            private _logicObj = _allLogicObjects select { name _x == _x } param [0, objNull];
            if (!isNull _logicObj && {_x != _selectedLogic}) then {
                deleteVehicle _logicObj;
                systemChat format ["Deleted logic and objects for %1", _x];
            };
        } forEach _allLogics;
    };

    // Debug notification
    systemChat format [
        "AO Linked to Base!\nSelected AO: %1\nLogic Kept: %2\nOther logics deleted.",
        _selectedAO,
        _selectedLogic
    ];
};