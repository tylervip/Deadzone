/*
    Dynamic AO System
    ----------------------------------------
    This script at mission startup selects a random "Possible_AO_X" marker on the map,
    then creates a circular AO marker of specified radius at a random
    position within the area of the selected marker.
    The selected AO marker is stored in the missionNamespace variable "Possible_AO_Selected".
    The script also spawns a separate thread to link the selected AO marker to its corresponding
    pre-made AO layer, hiding all other layers.
    Stores AO info in missionNamespace variables:
        "Selected_AO_Name" - name of the selected Possible AO marker
        "AO_Marker"            - handle to the created AO marker
*/

[] spawn {
    systemChat "Dynamic AO System starting...";

    // List of possible AO markers
    private _possibleAOs = [
        "Possible_AO_0","Possible_AO_1","Possible_AO_2","Possible_AO_3","Possible_AO_4",
        "Possible_AO_5","Possible_AO_6","Possible_AO_7","Possible_AO_8","Possible_AO_9",
        "Possible_AO_10","Possible_AO_11","Possible_AO_12","Possible_AO_13","Possible_AO_14"
    ];

    // Validate markers
    private _validAOs = _possibleAOs select { getMarkerPos _x isNotEqualTo [0,0,0] };
    if (_validAOs isEqualTo []) exitWith {
        systemChat "Error: No valid AO markers found!";
    };

    private _aoRadius = 1500; // AO radius (3000m diameter)

    // Pick a random Possible AO marker
    private _selectedMarkerName = selectRandom _validAOs;
    private _selectedMarkerPos = getMarkerPos _selectedMarkerName;

    // Save selected AO in missionNamespace
    missionNamespace setVariable ["Possible_AO_Selected", _selectedMarkerName];
    systemChat format ["Debug: Possible_AO_Selected set to %1", _selectedMarkerName];

    // Optional: create circular AO marker for gameplay
    private _markerAOName = "AO_DYNAMIC";
    deleteMarker _markerAOName; // Remove previous AO if exists
    private _markerAO = createMarker [_markerAOName, _selectedMarkerPos];
    _markerAO setMarkerShape "ELLIPSE";
    _markerAO setMarkerSize [_aoRadius*2, _aoRadius*2];
    _markerAO setMarkerColor "ColorRed";
    _markerAO setMarkerText "AO";

    missionNamespace setVariable ["AO_Marker", _markerAO];

    // Debug
    systemChat format [
        "Dynamic AO spawned!\nSelected AO: %1\nAO Center: %2",
        _selectedMarkerName,
        _selectedMarkerPos
    ];

    // Run linkAOtoBase.sqf to handle layer visibility
    call compile preprocessFileLineNumbers "functions\core\initAO\linkAOtoBase.sqf";
};
